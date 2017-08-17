//
//  Regex+Extension.swift
//  正则表达式扩展
//  Created by BigL055 on 16/7/25.
//  Copyright © 2016年 BigL.EnvironmentConfiguration.com. All rights reserved.
//

import UIKit


/// MAKE- 正则操作符定义: =~
struct RegexHelper {
  let regex: NSRegularExpression
  
  init(_ pattern: String) throws {
    try regex = NSRegularExpression(pattern: pattern,
                                    options: .caseInsensitive)
  }
  
  func match(inputStr: String) -> Bool {
    let matches = regex.matches(in: inputStr,
                                options: [],
                                range: NSMakeRange(0, inputStr.utf16.count))
    return matches.count > 0
  }
}

infix operator =~ {
associativity none
precedence 130
}

func =~(lhs: String, rhs: String) -> Bool {
  do {
    return try RegexHelper(rhs).match(inputStr: lhs)
  } catch _ {
    return false
  }
}


/*
 正则匹配库
 */
class Regex: NSObject {
  
  /// 手机号码校验
  static let isPhone = "^((13[0-9])|(14[0-9])|(15[^4,\\D])|(17[0-1,6-8])|(18[0-9]))\\d{8}$"
  /// 邮箱校验
  static let isEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
  /// 验证码
  static let isChackCode = "^\\d{4,6}$"
  /// 支付密码
  static let isPayPwd = "^\\d{6}$"
  /// 非正整数
  static let isPositiveInteger = "^\\d+$"
  /// 价格
  static let isPrice = "[1-9]\\d*.\\d*[1-9]\\d*"

  class func stringList(pattern: String,
                        inputStr: String) -> [String] {
    
    // 使用正则表达式一定要加try语句
    do {
      // - 1、创建规则
      let pattern = pattern
      // - 2、创建正则表达式对象
      let regex = try NSRegularExpression(pattern: pattern,
                                          options: NSRegularExpression.Options.caseInsensitive)
      // - 3、开始匹配
      let res = regex.matches(in: inputStr,
                              options: NSRegularExpression.MatchingOptions(rawValue: 0),
                              range: NSMakeRange(0, inputStr.characters.count))
      // 输出结果
      var subStrArray = [String]()
      for checkingRes in res {
        let subStr = (inputStr as NSString).substring(with: checkingRes.range)
        subStrArray.append(subStr)
      }
      return subStrArray
    }
    catch {
      print(error)
    }
    //不匹配返回空串
    return [String]()
  }
  
  /// 返回一个字典  key : 匹配到的字串, Value : 匹配到的字串的Range数组
  class func stringAndRangeList(pattern: String,inputStr: String) -> [[String : [NSRange]]]? {
    let strArray = stringList(pattern: pattern, inputStr: inputStr)
    var array = [[String : [NSRange]]]()
    for subStr in strArray {
      var dic = [String : [NSRange]]()
      let subStrRangeArray = rangeList(subStr: subStr, inputStr: inputStr)
      dic[subStr] = subStrRangeArray
      array.append(dic)
    }
    return array
  }
  
  /// 返回一个数组 Value : 匹配到的字串的Range数组
  class func rangeList(subStr : String, inputStr : String) -> [NSRange]? {
    guard inputStr =~ subStr else{
      return [NSMakeRange(0, 0)]
    }
    //设置Range数组
    var rangeArray = [NSRange]()
    //设置母串
    var bigString = inputStr
    // - 1、创建规则
    let pattern = subStr
    var count : Int = 0
    do{
      let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
      //获取子串个数
      count = regex.numberOfMatches(in: bigString, options: .reportProgress, range: NSMakeRange(0, bigString.characters.count))
    }catch{
      print(error)
    }
    for i in 0..<count {
      var subRange = (bigString as NSString).range(of: pattern)
      let cutLoc = subRange.location + subRange.length
      let cutLen = bigString.characters.count - cutLoc
      bigString = (bigString as NSString).substring(with: NSMakeRange(cutLoc, cutLen))
      if i > 0 {
        let preSubRange = rangeArray[i - 1]
        subRange.location = preSubRange.location + preSubRange.length
      }
      rangeArray.append(subRange)
    }
    
    return rangeArray
  }
}







