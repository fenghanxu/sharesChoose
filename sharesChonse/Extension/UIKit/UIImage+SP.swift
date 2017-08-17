//
//  aaa.swift
//  B7iOSShop
//
//  Created by 膳品科技 on 2016/11/11.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

extension SPExtension where Base: UIImage{

  /// 图片尺寸: Bytes
  var sizeAsBytes: Int
    { get{ return UIImageJPEGRepresentation(base, 1)?.count ?? 0 } }

  /// 图片尺寸: KB
  var sizeAsKB: Int {
    get{ let sizeAsBytes = self.sizeAsBytes
      return sizeAsBytes != 0 ? sizeAsBytes / 1024 : 0 } }

  /// 图片尺寸: MB
  var sizeAsMB: Int {
    get{ let sizeAsKB = self.sizeAsKB
      return sizeAsBytes != 0 ? sizeAsKB / 1024 : 0 } }

}

// MARK: - 初始化
extension UIImage{
  /// 从网络获取Image
  convenience init?(urlStr: String) {
    guard let url = URL(string: urlStr) else {
      self.init(data: Data())
      return
    }
    guard let data = try? Data(contentsOf: url) else {
      print("UIImage: 该URL资源不是Image类型 \(urlStr)")
      self.init(data: Data())
      return
    }
    self.init(data: data)
  }

  /// 获取指定颜色的图片
  ///
  /// - Parameters:
  ///   - color: UIColor
  ///   - size: 图片大小
  class func initWith(color: UIColor,
                      size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
    if size.width <= 0 || size.height <= 0 {
      return UIImage()
    }
    let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
    guard let context: CGContext = UIGraphicsGetCurrentContext() else {
      UIGraphicsEndImageContext()
      return UIImage()
    }
    context.setFillColor(color.cgColor)
    context.fill(rect)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
      UIGraphicsEndImageContext()
      return UIImage()
    }
    UIGraphicsEndImageContext()
    return image
  }

}

// MARK: - 类方法
extension UIImage{

  /// 返回一张没有被渲染图片
  ///
  /// - Parameter original: 图片/图片名称
  /// - Returns: 返回一张没有被渲染的图片
  class func deal(original: SPImageTarget) -> UIImage {
    if let original = original as? UIImage {
      return original.withRenderingMode(.alwaysOriginal)
    }else if let original = original as? String {
      guard let image = UIImage(named: original) else{
        return UIImage()
      }
      return UIImage.deal(original: image)
    }
    fatalError("UIImage:round 类型错误:\(round)")
  }

  /// 图像处理: 裁圆
  ///
  /// - Parameter round: 需处理的图片/图片名称
  /// - Returns: 新图
  class func deal(round: SPImageTarget) -> UIImage {
    if let round = round as? UIImage{
      return round.sp.dealWithRound(radius: round.size.height * 0.5,
                                    corners: UIRectCorner.allCorners,
                                    borderWidth: 0,
                                    borderColor: nil,
                                    borderLineJoin: .miter)
    }
    else if let round = round as? String {
      guard let image = UIImage(named: round) else{
        return UIImage()
      }
      return UIImage.deal(original: image)
    }
    fatalError("UIImage:round 类型错误:\(round)")
  }
}

// MARK: - 图片处理
extension SPExtension where Base: UIImage{

  /// 裁剪对应区域
  ///
  /// - Parameter bound: 裁剪区域
  /// - Returns: 新图
  public func dealWithCrop(bound: CGRect) -> UIImage {
    guard base.size.width > bound.origin.x else {
      print("UIImage: 裁剪宽度超出图片宽度")
      return base
    }
    guard base.size.height > bound.origin.y else {
      print("UIImage: 裁剪高度超出图片高度")
      return base
    }
    let scaledBounds: CGRect = CGRect(x: bound.origin.x * base.scale,
                                      y: bound.origin.y * base.scale,
                                      width: bound.size.width * base.scale,
                                      height: bound.size.height * base.scale)
    let imageRef = base.cgImage?.cropping(to: scaledBounds)
    let croppedImage: UIImage = UIImage(cgImage: imageRef!, scale: base.scale, orientation: UIImageOrientation.up)
    return croppedImage
  }

  /// 图像处理: 裁圆
  /// - Parameters:
  /// - radius: 圆角大小
  /// - corners: 圆角区域
  /// - borderWidth: 描边大小
  /// - borderColor: 描边颜色
  /// - borderLineJoin: 描边类型
  /// - Returns: 新图
  func dealWithRound(radius: CGFloat,
                     corners: UIRectCorner = .allCorners,
                     borderWidth: CGFloat = 0,
                     borderColor: UIColor? = nil,
                     borderLineJoin: CGLineJoin = .miter) -> UIImage {
    var corners = corners

    if corners != UIRectCorner.allCorners {
      var  tmp: UIRectCorner = UIRectCorner(rawValue: 0)
      if (corners.rawValue & UIRectCorner.topLeft.rawValue) != 0
      { tmp = UIRectCorner(rawValue: tmp.rawValue | UIRectCorner.bottomLeft.rawValue) }
      if (corners.rawValue & UIRectCorner.topLeft.rawValue) != 0
      { tmp = UIRectCorner(rawValue: tmp.rawValue | UIRectCorner.bottomRight.rawValue) }
      if (corners.rawValue & UIRectCorner.bottomLeft.rawValue) != 0
      { tmp = UIRectCorner(rawValue: tmp.rawValue | UIRectCorner.topLeft.rawValue) }
      if (corners.rawValue & UIRectCorner.bottomRight.rawValue) != 0
      { tmp = UIRectCorner(rawValue: tmp.rawValue | UIRectCorner.topRight.rawValue) }
      corners = tmp
    }
    UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
    guard let context: CGContext = UIGraphicsGetCurrentContext() else {
      UIGraphicsEndImageContext()
      return UIImage()
    }
    let rect: CGRect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
    context.scaleBy(x: 1, y: -1)
    context.translateBy(x: 0, y: -rect.height)
    let minSize: CGFloat = min(base.size.width, base.size.height)

    if borderWidth < minSize * 0.5{
      let path = UIBezierPath(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth),
                              byRoundingCorners: corners,
                              cornerRadii: CGSize(width: radius, height: borderWidth))

      path.close()
      context.saveGState()
      path.addClip()
      guard let cgImage = base.cgImage else {
        UIGraphicsEndImageContext()
        return UIImage()
      }
      context.draw(cgImage, in: rect)
      context.restoreGState()
    }

    if (borderColor != nil && borderWidth < minSize / 2 && borderWidth > 0) {
      let strokeInset: CGFloat = (floor(borderWidth * base.scale) + 0.5) / base.scale
      let strokeRect = rect.insetBy(dx: strokeInset, dy: strokeInset)
      let strokeRadius: CGFloat = radius > base.scale / 2 ? CGFloat(radius - base.scale / 2) : 0
      let path = UIBezierPath(roundedRect: strokeRect, byRoundingCorners: corners, cornerRadii: CGSize(width: strokeRadius, height: borderWidth))
      path.close()
      path.lineWidth = borderWidth
      path.lineJoinStyle = borderLineJoin
      borderColor?.setStroke()
      path.stroke()
    }
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
      UIGraphicsEndImageContext()
      return UIImage()
    }
    UIGraphicsEndImageContext()
    return image
  }

  /// 图像处理: 裁圆
  ///
  /// - Returns: 新图
  func dealWithRound() -> UIImage {
    return dealWithRound(radius: base.size.height < base.size.width ? base.size.height : base.size.width,
                         corners: .allCorners,
                         borderWidth: 0,
                         borderColor: nil,
                         borderLineJoin: .miter)
  }

  /// 返回被渲染的图片
  ///
  /// - Returns: 返回一张没有被渲染的图片
  func dealWithOriginal() {
    base.withRenderingMode(.alwaysOriginal)
  }

  /// 根据宽度获取对应高度
  ///
  /// - Parameter width: 宽度
  /// - Returns: 新高度
  func aspectHeight(with width: CGFloat) -> CGFloat {
    return (width * base.size.height) / base.size.width
  }

  /// 根据高度获取对应宽度
  ///
  /// - Parameter height: 高度
  /// - Returns: 宽度
  func aspectWidth(with height: CGFloat) -> CGFloat {
    return (height * base.size.width) / base.size.height
  }

  /// 重设图片大小
  ///
  /// - Parameter size: 新的尺寸
  /// - Returns: 新图
  func reSize(size: CGSize)->UIImage {
    UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.main.scale)
    base.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let reSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return reSizeImage
  }

  /// 根据宽度重设大小
  ///
  /// - Parameter width: 宽度
  /// - Returns: 新图
  func resize(width: CGFloat) -> UIImage {
    let aspectSize = CGSize (width: width, height: aspectHeight(with: width))

    UIGraphicsBeginImageContext(aspectSize)
    base.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return img!
  }

  /// 根据高度重设大小
  ///
  /// - Parameter height: 高度
  /// - Returns: 新图
  func resize(height: CGFloat) -> UIImage {
    let aspectSize = CGSize (width: aspectWidth(with: height), height: height)

    UIGraphicsBeginImageContext(aspectSize)
    base.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return img!
  }

}

// MARK: - 尺寸相关
extension SPExtension where Base: UIImage{

  /// 等比率缩放
  ///
  /// - Parameter multiple: 倍数
  /// - Returns: 新图
  func scale(multiple: CGFloat)-> UIImage {
    let newSize = CGSize(width: base.size.width * multiple, height: base.size.height * multiple)
    return reSize(size: newSize)
  }

  /// 压缩图片
  ///
  /// - Parameter rate: 压缩比率
  /// - Returns: 新图
  func compress(rate: CGFloat) -> Data? {
    return UIImageJPEGRepresentation(base, rate)
  }


}

protocol SPImageTarget { }
extension String: SPImageTarget{ }
extension UIImage: SPImageTarget{ }
