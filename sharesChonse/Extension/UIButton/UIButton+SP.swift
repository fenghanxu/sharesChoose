//
//  UIButton+SP.swift
//  B7iOSShop
//
//  Created by 膳品科技 on 2016/11/14.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

extension UIButton {

  /// 设置背景颜色
  ///
  /// - Parameters:
  ///   - color: color
  ///   - forState: Button状态
  func setBackgroundColor(color: UIColor,for forState: UIControlState) {
    UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
    UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
    UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.setBackgroundImage(colorImage, for: forState)
  }

}
