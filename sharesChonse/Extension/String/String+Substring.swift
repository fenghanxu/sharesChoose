//
//  StringAsNSString.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/8/10.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit

// MARK: - 类似NSString处理方法
extension String {

    /*  检测字符串所在位置
     let num:String = "15989954385"
     print("\(num.getIndexOf("3"))")
     */
  /// 获取指定字符所在索引
  public func getIndexOf(_ char: Character) -> Int? {
    for (index, c) in characters.enumerated() {
      if c == char {
        return index
      }
    }
    return nil
  }

    /*
     let num:String = "15989954385"
     print("\(num.length)")
     */
  /// 字符长度
  public var length: Int{
    get{
      return self.characters.count
    }
  }

    /*
     let num:String = "15989954385"
     print("\(num.append("ok"))")
     */
  /// 字符串拼接字符串
  ///
  /// - Parameter string: 子串
  /// - Returns: 新串
  public func append(_ string: String) -> String {
    return self + string
  }

  /// 截取: 区间内的子串
  ///
  /// - Parameter closedRange: 区间
  public subscript(range: Range<Int>) -> String {
    let start = characters.index(startIndex, offsetBy: range.lowerBound)
    let end = characters.index(startIndex, offsetBy: range.upperBound)
    return self[start..<end]
  }
  
  /// 截取: 区间内的子串
  ///
  /// - Parameter closedRange: 区间
  public subscript(closedRange: ClosedRange<Int>) -> String {
    return self[closedRange.lowerBound..<(closedRange.upperBound + 1)]
  }
  
  /// 返回限定范围内子串
  ///
  /// - Parameters:
  ///   - loc: 起始位置
  ///   - len: 结束位置
  /// - Returns: 新串
  public func substring(from: Int,to: Int) -> String {
    guard from >= 0 else{ return self }
    guard to >= 0 else{ return self }
    guard self.characters.count - 1 > from else{ return self }
    guard self.characters.count - 1 > to else{ return self }
    return (self as NSString).substring(with: NSMakeRange(from, to))
  }

  /// 返回限定起始位置后子串
  ///
  /// - Parameter from: 起始位置
  /// - Returns: 新串
  public func substring(from: Int) -> String {
    guard from >= 0 else{ return self }
    guard self.characters.count > from else{ return self }
    return (self as NSString).substring(from: from)
  }

  /// 返回限定截止位置前内子串
  ///
  /// - Parameter to: 截止位置
  /// - Returns: 新串
  public func substring(to: Int) -> String {
    guard to >= 0 else{ return self }
    guard self.characters.count - 1 >= to else{ return self }
    return (self as NSString).substring(to: to)
  }

  /// 返回指定字符串前的子串
  ///
  /// - Parameter to: 指定字符串
  /// - Returns: 新串
  public func substring(to: String) -> String {
    guard let range: Range = self.range(of: to) else { return self }
    return self.substring(to: range.lowerBound)
  }

  /// 返回指定字符串后的子串
  ///
  /// - Parameter from: 指定字符串
  /// - Returns: 新串
  public func substring(from: String) -> String {
    guard let range: Range = self.range(of: from) else { return self }
    return self.substring(from: range.upperBound)
  }
}

