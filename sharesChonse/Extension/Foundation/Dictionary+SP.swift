//
//  Dictionary+SP.swift
//  B7iOSShop
//
//  Created by 膳品科技 on 2016/11/14.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

extension Dictionary {
    /*
     let dict1:String = dict.random获取一个随机值
     */
  /// 从字典中随机取值
  ///
  /// - Returns: 值
  public var random: Value {
    get{
      let index: Int = Int(arc4random_uniform(UInt32(self.count)))
      return Array(self.values)[index]
    }
  }
  
    /*检测值是否有值
     let dict: [String: String] =
     ["name": "liudehua",
     "age": "55",
     "tag": "web",
     "is": "asd",
     "qwe": "afd"]
     let dict2:Bool = dict.has(key: "name")
     print("dict = \(dict2)")
     */
  /// 检查是否有值
  ///
  /// - Parameter key: key名
  /// - Returns: 是否
  public func has(key: Key) -> Bool {
    return index(forKey: key) != nil
  }
  
    /* 合拼字典
     let dict3: [String: String] =
     ["name": "liudehua"]
     let dict4: [String: String] =
     ["age": "55"]
     let dict5: [String: String] =
     dict3.update(dicts: dict4)
     */
  /// 更新字典
  ///
  /// - Parameter dicts: 单个/多个字典
  /// - Returns: 新字典
  public func update(dicts: Dictionary...) -> Dictionary {
    var result = self
    dicts.forEach { (dictionary) -> Void in
      dictionary.forEach { (key, value) -> Void in
        _ = result.updateValue(value, forKey: key)
      }
    }
    return result
  }
  

  /// 过滤
  ///
  /// - Parameter test: true的值不会被过滤/false会被过滤
  /// - Returns: 新字典
  public func filter(test: (Key, Value) -> Bool) -> Dictionary {
    var result = Dictionary()
    for (key, value) in self {
      if test(key, value) {
        result[key] = value
      }
    }
    return result
  }
  
  /// 检查: 测试所有元素
  ///
  /// - Parameter test: 测试闭包
  /// - Returns: 是否通过测试
  public func testAll(test: (Key, Value) -> (Bool)) -> Bool {
    for (key, value) in self {
      if !test(key, value) {
        return false
      }
    }
    return true
  }
  
  /// 格式化为Json
  ///
  /// - Returns: Json字符串
  public func formatJSON(prettify: Bool = false) -> String {
    guard JSONSerialization.isValidJSONObject(self) else {
      return "{}"
    }
    let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
      return String(data: jsonData, encoding: .utf8) ?? "{}"
    } catch {
      return "{}"
    }
  }

}
