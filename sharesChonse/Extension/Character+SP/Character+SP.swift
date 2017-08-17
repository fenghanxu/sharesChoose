//
//  Character+SP.swift
//  B7iOSShop
//
//  Created by BigL on 2016/12/13.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

// MARK: - Properties
public extension Character {
  //检测表情符号
  /// Check: emoji
  public var isEmoji: Bool {
    guard let scalarValue = String(self).unicodeScalars.first?.value else {
      return false
    }
    switch scalarValue {
    case 0x3030, 0x00AE, 0x00A9,
    0x1D000...0x1F77F,
    0x2100...0x27BF,
    0xFE00...0xFE0F,
    0x1F900...0x1F9FF:
      return true
    default:
      return false
    }
  }
  
  /// check: 数字
  public var isNumber: Bool {
    return Int(String(self)) != nil
  }
  
  /// 转换: int
  public var int: Int? {
    return Int(String(self))
  }
  
  /// 转换: string
  public var string: String {
    return String(self)
  }
  
}


// MARK: - Operators
public extension Character {

  /// 获取重复字节
  ///
  /// - Parameters:
  ///   - lhs: 字节
  ///   - rhs: 重复次数
  /// - Returns: 字符串
  static public func * (lhs: Character, rhs: Int) -> String {
    var newString = ""
    for _ in 0 ..< rhs {
      newString += String(lhs)
    }
    return newString
  }
  

  /// 获取重复字节
  ///
  /// - Parameters:
  ///   - lhs: 重复次数
  ///   - rhs: 字节
  /// - Returns: 字符串
  static public func * (lhs: Int, rhs: Character) -> String {
    var newString = ""
    for _ in 0 ..< lhs {
      newString += String(rhs)
    }
    return newString
  }
  
}
