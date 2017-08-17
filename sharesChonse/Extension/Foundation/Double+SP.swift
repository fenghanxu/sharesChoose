//
//  Double+SP.swift
//  B7iOSShop
//
//  Created by 膳品科技 on 2016/11/14.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import Foundation
import UIKit
extension Double {

  /// Double转Int
  public var int: Int { return Int(self) }
  /// Double转String
  public var string: String { return String(self) }
  /// Double转CGFloat
  public var cgFloat: CGFloat { return CGFloat(self) }
  /// Double转Float
  public var float: Float { return Float(self) }
  
  /// 绝对值
  public var abs: Double { return Swift.abs(self) }
  /// 向上取整
  public var ceil: Double { return Foundation.ceil(self) }
  /// 向下取整
  public var floor: Double { return Foundation.floor(self) }
  
  /// 中国区价格类型
  public var price: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "ii_CN")
    return formatter.string(from: self as NSNumber)!
  }
  
  /// 当地价格类型
  public var localePrice: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    return formatter.string(from: self as NSNumber)!
  }

  
  /// 随机值
  ///
  /// - Parameters:
  ///   - min: 最小值
  ///   - max: 最大值
  /// - Returns: 随机值
  public static func random(in min: Double, max: Double) -> Double {
    let delta = max - min
    return min + Double(arc4random_uniform(UInt32(delta)))
  }
}
