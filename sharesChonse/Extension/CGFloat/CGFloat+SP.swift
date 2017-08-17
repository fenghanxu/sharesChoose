//
//  CGFloat+SP.swift
//  B7iOSBuy
//
//  Created by BigL on 2016/11/18.
//  Copyright © 2016年 b7iosbuy.spzjs.com. All rights reserved.
//

//import Foundation
import UIKit

extension Float{
  public var cgFloat: CGFloat { return CGFloat(self) }
}

extension CGFloat{
     /*
     let values:CGFloat = -1.2
     print("\(values.abs)")
     */
  /// 绝对值
  public var abs: CGFloat { return Swift.abs(self) }
  /// 向上取整  超过0.1就往上取证
  public var ceil: CGFloat { return Foundation.ceil(self) }
  /// 向下取整  1.9都要输出是1
  public var floor: CGFloat { return Foundation.floor(self) }
  /// 类型转换成Srting
  public var string: String { return description }
  /// 类型转换成int
  public var int: Int { return Int(self) }
  /// 类型转换成float
  public var float: Float { return Float(self) }
  
  /// 随机值
  ///
  /// - Parameters:
  ///   - min: 最小值
  ///   - max: 最大值
  /// - Returns: 随机值
  public static func random(in min: CGFloat, max: CGFloat) -> CGFloat {
    let delta = max - min
    return min + CGFloat(arc4random_uniform(UInt32(delta)))
  }
}
