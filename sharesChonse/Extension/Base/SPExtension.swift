//
//  SPExtension.swift
//  B7iOSShop
//
//  Created by 膳品科技 on 2016/11/10.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

public struct SPExtension<Base> {
  public let base: Base
  public init(_ base: Base) {
    self.base = base
  }
}

public extension NSObjectProtocol {
  public var sp: SPExtension<Self> {
    return SPExtension(self)
  }
}

extension SPExtension where Base: UILabel{
  /// 改变字体大小 增加或者减少
  /// - Parameter offSet: 变化量
  func change(with offSet: CGFloat) {
    let textFont = base.font.pointSize
    base.font = UIFont.systemFont(ofSize: textFont + offSet)
  }
}

extension SPExtension where Base: NSLayoutConstraint {
  /// 改变Constant 增加或者减少
  /// - Parameter offSet: 变化量
  func change(with offSet: CGFloat) {
    let nowConstant = base.constant
    base.constant += nowConstant
  }
  
}
