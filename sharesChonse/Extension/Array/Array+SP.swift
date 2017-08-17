//
//  Array+SP.swift
//  B7iOSShop
//
//  Created by 膳品科技 on 2016/11/15.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

public func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
  switch (lhs, rhs) {
  case (.some(let lhs), .some(let rhs)):
    return lhs == rhs
  case (.none, .none):
    return true
  default:
    return false
  }
}

extension Array {

    /*从数组中抽出一个随机数
     let arr2 = [1, 2, 3, 4, 5, 6, 7, 8, 9 ,0]
     print("\(arr2.random)")
     */
  /// 随机值
  public var random: Element? {
    get{
      guard count > 0 else { return nil }
      let index = Int(arc4random_uniform(UInt32(self.count)))
      return self[index]
    }
  }

    /*从新布局数组
     let arr2 = [1, 2, 3, 4, 5, 6, 7, 8, 9 ,0]
     let arr3 = arr2.shuffled
     for index in 0..<arr3.count {
     print("\(arr3[index])")
     }
     */
  /// 打乱数组
  public var shuffled: Array {
    get{
      var result = self
      result.shuffle()
      return result
    }
  }

    /* 打印 4  5  6
     let arr2 = [1, 2, 3, 4, 5, 6, 7, 8, 9 ,0]
     let arr3 = arr2.subArray(lower: 3, upper: 5)
     for index in 0..<arr3.count {
     print("\(arr3[index])")
     }
     */
  /// 获取: 指定范围的数组
  ///
  /// - Parameter range: 指定范围/或者指定位置
  /// - Returns: 新数组
  public func subArray(lower: Int,upper: Int) -> Array {
    var subArr = Array()
    for index in lower...upper {
      subArr.append(self[index])
    }
    return subArr
  }

    /*获取数组范围
     let arr2 = [1, 2, 3, 4, 5, 6, 7, 8, 9 ,0]
     let arr3 = arr2.subArray(to: 4)
     for index in 0..<arr3.count {
     print("\(arr3[index])")
     }
     */
    
  //(不包括写入的数字)
  /// 获取: 从起始位置到指定最大数量之间的数组
  ///
  /// - Parameter to: 指定数量
  /// - Returns: 子数组
    public func subArray(to: Int) -> Array {
        guard to < count else { return self }
        guard to >= 0 else { return self }
        return Array(self[0..<to])
    }
    
    //(包括写入的数字)
    /// 获取: 从起始位置到指定最大数量之间的数组
    ///
    /// - Parameter to: 指定数量
    /// - Returns: 子数组
    public func subArray(from: Int) -> Array {
        guard from < count else { return self }
        guard from >= 0 else { return self }
        return Array(self[from..<count])
    }


    /* 获取数组中下标对应的值
     let arr2 = [1, 2, 3, 4, 5, 6, 7, 8, 9 ,0]
     print("\(arr2.value(at: 4))")
     */
  /// 获取: 指定位置的值
  ///
  /// - Parameter index: 指定序列
  /// - Returns: 值
  public func value(at index: Int) -> Element? {
    guard index >= 0 && index < count else { return nil }
    return self[index]
  }

    /*
     
     */
  /// 获取:反向序列的值
  ///
  /// - Parameter index: 序列
  /// - Returns: 指定值
  public func value(reverse index: Int) -> Int? {
    guard index >= 0 && index < count else { return nil }
    return Swift.max(self.count - index, 0)
  }
    

    /*
     
     */
  /// 打乱数组
  public mutating func shuffle() {
    guard self.count > 1 else { return }
    var j: Int
    for i in 0..<(self.count-2) {
      j = Int(arc4random_uniform(UInt32(self.count - i)))
      if i != i+j { swap(&self[i], &self[i+j]) }
    }
  }

    /*
     
     */
  /// 分解数组:元组(第一个元素,余下的数组)
  ///
  /// - Returns: 元组(第一个元素,余下的数组)
  public func decompose() -> (head: Iterator.Element, tail: SubSequence)? {
    return (count > 0) ? (self[0], self[1..<count]) : nil
  }

    /*
     
     */
  /// 检查: 测试所有元素
  ///
  /// - Parameter test: 测试闭包
  /// - Returns: 是否通过测试
  public func testAll(body: @escaping (Element) -> Bool) -> Bool {
    return self.first { !body($0) } == nil
  }
  
}


