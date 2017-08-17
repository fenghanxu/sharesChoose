//
//  UIView+SP.swift
//  B7iOSShop
//
//  Created by 膳品科技 on 2016/11/11.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

extension UIView{

  /// 圆角
  var cornerRadius: CGFloat {
    get{ return self.layer.cornerRadius }
    set{
      self.layer.cornerRadius = newValue
      self.layer.masksToBounds = true
    }
  }
  /// 边框宽度
  var borderWidth: CGFloat {
    get{ return self.layer.borderWidth }
    set{ self.layer.borderWidth = newValue }
  }

  /// 边框颜色
  var borderColor: UIColor  {
    get{
      guard let temp: CGColor = self.layer.borderColor else {
        return UIColor.clear
      }
      return UIColor(cgColor: temp)
    }
    set { self.layer.borderColor = newValue.cgColor }
  }

  /// 背景图片
  var image: UIImage {
    get{
      guard let temp: Any = self.layer.contents else {
        return UIImage()
      }
      return UIImage.init(cgImage: temp as! CGImage)
    }
    set { self.layer.contents = newValue.cgImage }
  }

}

extension SPExtension where Base: UIView{

  /// 返回目标View所在的控制器UIViewController
  var viewController: UIViewController {
    get{
      var next:UIView? = base
      repeat{
        if let nextResponder = next?.next, nextResponder as? UIViewController != nil{
          return (nextResponder as! UIViewController)
        }
        next = next?.superview
      }while next != nil
      fatalError("无法从该View上寻找到viewController \n Couldn’t find viewController from view: \(base)")
    }
  }

  /// 对当前View快照
  var snapshoot: UIImage{
    get{
      UIGraphicsBeginImageContextWithOptions(base.bounds.size, base.isOpaque, 0)
      base.layer.render(in: UIGraphicsGetCurrentContext()!)
      guard let snap = UIGraphicsGetImageFromCurrentImageContext() else {
        UIGraphicsEndImageContext()
        return UIImage()
      }
      UIGraphicsEndImageContext()
      return snap
    }
  }

  /// 移除View全部子控件
  func removeSubviews() {
    for _ in 0..<base.subviews.count {
      base.subviews.last?.removeFromSuperview()
    }
  }

  /// 设置LayerShadow,offset,radius
  fileprivate func setLayerShadow(color: UIColor, offset: CGSize,radius: CGFloat) {
    base.layer.shadowColor = color.cgColor
    base.layer.shadowOffset = offset
    base.layer.shadowRadius = radius
    base.layer.shadowOpacity = 1
    base.layer.shouldRasterize = true
    base.layer.rasterizationScale = UIScreen.main.scale
  }
  
}

