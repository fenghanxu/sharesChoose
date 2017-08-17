//
//  Int+SP.swift
//  B7iOSShop
//
//  Created by 膳品科技 on 2016/11/15.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit


extension Int {
  /// 绝对值
  public var abs: Int { return Swift.abs(self) }
  
  /// 检查: 是否为偶数
  public var isEven: Bool { return (self % 2 == 0) }
  /// 检查: 是否为奇数
  public var isOdd: Bool { return (self % 2 != 0) }
  /// 检查: 是否为正数
  public var isPositive: Bool { return (self > 0) }
  /// 检查: 是否为负数
  public var isNegative: Bool { return (self < 0) }
  
  /// 转换: Double.
  public var double: Double { return Double(self) }
  /// 转换: Float.
  public var float: Float { return Float(self) }
  /// 转换: CGFloat.
  public var cgFloat: CGFloat { return CGFloat(self) }
  /// 转换: String.
  public var string: String { return String(self) }
  /// 转换: Bool.
  public var bool: Bool { return self == 0 ? false : true }
  /// 转换: UInt.
  public var uint: UInt { return UInt(self) }
  /// 转换: Int32.
  public var int32: Int32 { return Int32(self) }
  /// 转换: Range: 0..<Int
  public var range: CountableRange<Int> { return 0..<self }

  /// 计算: 位数
  public var digits: Int {
    if self == 0 {
      return 1
    } else if Int(fabs(Double(self))) <= LONG_MAX {
      return Int(log10(fabs(Double(self)))) + 1
    } else {
      return -1
    }
  }

}

extension UInt {
  /// 转换: Int
  public var int: Int { return Int(self) }
  /// 转换: String.
  public var string: String { return String(self) }
}

public extension Int {
    
    /// 执行self次回调
    ///
    /// - Parameter callback: 回调
    public func times(callback: @escaping (Int) -> Void) {
        (0..<self).forEach(callback)
    }
    
    /// 执行self次回调
    ///
    /// - Parameter callback: 回调
    public func times(function: @escaping (Void) -> Void) {
        self.times { (index: Int) -> Void in
            function()
        }
    }
    
}
