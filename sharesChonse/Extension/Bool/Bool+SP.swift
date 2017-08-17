//
//  Bool+SP.swift
//  B7iOSShop
//
//  Created by 膳品科技 on 2016/11/14.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

extension Bool {
    /*  类型转换
     let values:Bool = true
     print("\(values.int)")
     print("\(values.string)")
     print("\(values.toggled)")
     print("\(values.cgFloat)")
     */
  /// Bool转Int  value: 1 : 0
  var int: Int { return self ? 1 : 0 }
  /// Bool转String   value: "1" : "0"
  var string: String { return description }
  
  /// 取反
  public var toggled: Bool { return !self }
  
  /// 转换: CGFloat.
  public var cgFloat: CGFloat { return CGFloat(self.int) }
  
}

extension Bool{
  /// 取反
  @discardableResult public mutating func toggle() -> Bool {
    self = !self
    return self
  }
}
