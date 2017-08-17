//
//  UITextField+SP.swift
//  B7iOSShop
//
//  Created by BigL on 2016/11/15.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

extension UITextField{
  
  /// 占位文字颜色
  var placeHolderColor: UIColor {
    get{ return self.placeHolderColor }
    set {
      guard let placeholder = self.placeholder else {
        return
      }
      self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                      attributes: [NSForegroundColorAttributeName: newValue])
    }
  }
  
  /// 左边间距
  public var leftPadding: CGFloat{
    get{ return self.leftView?.frame.size.width ?? 0 }
    set{
      checkLeftView()
      self.leftView?.frame.width = newValue
    }
  }
  
  /// 左边图标 -- 暂时用不了，没了没有测试
  public var leftIcon: UIImage{
    get{
      guard let cgImage = self.leftView?.layer.contents else {
        return UIImage()
      }
      return UIImage(cgImage: cgImage as! CGImage)
    }
    set{
      checkLeftView()
      self.leftView?.layer.contents = newValue.cgImage
    }
  }
  
  /// 右边间距
  public var rightPadding: CGFloat{
    get{
      guard self.rightView != nil else {
        return 0
      }
      return self.frame.size.width
        - (self.rightView?.frame.origin.x)!
        - (self.rightView?.frame.size.width)!
    }
    set{
      checkRightView()
      self.rightView?.frame.size.width = newValue
    }
  }
  
  /// 右边图标 -- 暂时用不了，没了没有测试
  public var rightIcon: UIImage{
    get{
      guard let cgImage = self.rightView?.layer.contents else {
        return UIImage()
      }
      return UIImage(cgImage: cgImage as! CGImage)
    }
    set{
      checkRightView()
      self.rightView?.layer.contents = newValue.cgImage
    }
  }
  
    //这个方法在当前文件使用
  private func checkLeftView() {
    self.leftViewMode = .always
    if self.leftView == nil {
      self.leftView = UIView(frame: CGRect(x: 0,y: 0,
                                           width: self.frame.size.height,
                                           height: self.frame.size.height))
    }
  }
  
    //这个方法在当前文件使用
  private func checkRightView() {
    self.rightViewMode = .always
    if self.rightView == nil {
      self.rightView = UIView(frame: CGRect(x: self.frame.size.width - self.frame.size.height,
                                            y: 0,
                                            width: self.frame.size.height,
                                            height: self.frame.size.height))
    }
  }
  
}

