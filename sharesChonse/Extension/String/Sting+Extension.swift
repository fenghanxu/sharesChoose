//
//  Sting+Extension.swift
//  EnvironmentConfiguration
//
//  Created by BigL055 on 16/7/25.
//  Copyright © 2016年 BigL.EnvironmentConfiguration.com. All rights reserved.
//
import UIKit

public let NullString = ""

// MARK: - 转换
extension String {
  
    /*
     let num:String = "12"
     print("\(num.int)")
     */
  /// String: 转化为Int
  var int: Int? {
    get{
      if let num = NumberFormatter().number(from: self) {
        return num.intValue
      } else {
        return nil
      }
    }
  }
  
    /*
     let num:String = "12"
     print("\(num.double)")
     */
  /// String: 转化为 Double
  var double: Double? {
    get{
      if let num = NumberFormatter().number(from: self) {
        return num.doubleValue
      } else {
        return nil
      }
    }
  }
  
    /*
     let num:String = "12"
     print("\(num.float)")
     */
  /// String: 转化为Float
  var float: Float? {
    get{
      if let num = NumberFormatter().number(from: self) {
        return num.floatValue
      } else {
        return nil
      }
    }
  }
  
    /*
     let num:String = "12"
     print("\(num.number)")
     */
  /// String: 转化为 NSNumber
  var number: NSNumber? {
    if let num = NumberFormatter().number(from: self) {
      return num
    } else {
      return nil
    }
  }
  
    /*
     let num:String = "12"
     print("\(num.bool)")
     */
  /// String: 转化为 Bool
  var bool: Bool? {
    get{
      if let num = NumberFormatter().number(from: self) {
        return num.boolValue
      }
      switch self {
      case "true","TRUE","yes","YES","1":
        return true
      case "false","FALSE","no","NO","0":
        return false
      default:
        return nil
      }
    }
  }
  
    /*
     let num:String = "12"
     print("\(num.date)")
     */
  /// String: 转化为 Date,  格式: "yyyy-MM-dd"
  public var date: Date? {
    let selfLowercased = self.trimmed.lowercased()
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: selfLowercased)
  }
  
    /*
     let num:String = "12"
     print("\(num.dateTime)")
     */
  /// String: 转化为 Date, 格式: "yyyy-MM-dd HH:mm:ss"
  public var dateTime: Date? {
    let selfLowercased = self.trimmed.lowercased()
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter.date(from: selfLowercased)
  }
}

// MARK: - Check
extension String{
  
  /// Check:
  public var hasLetters: Bool {
    return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
  }
  
  /// Check: 检查是否含有数字
  public var hasNumbers: Bool {
    return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
  }
  
  ///  Check: 检查是否为Email
  public var isEmail: Bool {
    let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
    return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
  }
  
  /// Check: 是否为合法字符
  var isLawful: Bool {
    let str = self.removeLawful
    let result = str.length == self.length
    return result
  }
  
  /// 是否为手机号码
  var isPhone: Bool {
    return self =~ Regex.isPhone
  }
  
}

extension String{
  /// 移除非法字符
  ///
  /// - returns: 新串
  public var removeLawful: String {
    let array = ["/","\\",
                 "[","]",
                 "{","}",
                 "<",">",
                 "＜","＞",
                 "「","」",
                 "：","；",
                 "、","•",
                 "^","'","\"",
                 "\r","\r\n","\\n","\n"]
    var str = self
    for char in array {
      str = str.replacingOccurrences(of: char, with: NullString)
    }
    return str
  }
  
  /// remove: 首尾空格与换行
  public var trimmed: String {
    return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }
  
  /// remove: 空格与换行
  public var withoutSpacesAndNewLines: String {
    return replacing(" ", with: NullString).replacing("\n", with: NullString)
  }
  
  /// string: 反转 string.
  public var reversed: String { return String(characters.reversed()) }
  
  /// string: 反转 string.
  public mutating func reverse() {
    self = String(characters.reversed())
  }
  
  /// 替换
  ///
  /// - Parameters:
  ///   - string: 代替换文本
  ///   - newString: 替换文本
  /// - Returns: 新串
  public func replacing(_ string: String, with newString: String) -> String {
    return replacingOccurrences(of: string, with: newString)
  }
}

// MARK: - 提取
extension String{
  
  /// 验证是否为指定位数数字
  ///
  /// - Parameter digit: 位数
  /// - Returns: 是否
  func isNumber(digit: Int) -> Bool{
    return self =~ "^\\d{\(digit)}$"
  }
  
  /// 提取: 提取URLs
  public var extractURLs: [URL] {
    var urls: [URL] = []
    let detector: NSDataDetector?
    do {
      detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    } catch _ as NSError {
      detector = nil
    }
    
    let text = self
    
    if let detector = detector {
      detector.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count), using: {
        (result: NSTextCheckingResult?, flags: NSRegularExpression.MatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
        if let result = result, let url = result.url {
          urls.append(url)
        }
      })
    }
    
    return urls
  }
  
}

// MARK: - Emoji
extension String{
  /// 检查: 是否含有Emoji
  public var hasEmoji: Bool {
    get{
      for scalar in unicodeScalars {
        switch scalar.value {
        case 0x3030, 0x00AE, 0x00A9,
             0x1D000...0x1F77F,
             0x2100...0x27BF,
             0xFE00...0xFE0F,
             0x1F900...0x1F9FF:
          return true
        default:
          continue
        }
      }
      return false
    }
  }
  
  /// 提取: Emojis
  public var emojis: [String] {
    let unicodes = emojiFilter(isEmoji: true)
    var emojis = [String]()
    for unicode in unicodes {
      emojis.append(unicode.description)
    }
    return emojis
  }
  
  /// 移除: Emojis
  public var removedEmoji: String{
    let unicodes = emojiFilter(isEmoji: false)
    var s = ""
    for item in unicodes {
      s += item.description
    }
    return s
  }

}



// MARK: - 文本区域
extension String{
  /**
   获取字符串的Bounds
   - parameter font: 字体大小
   - parameter size: 字符串长宽限制
   - returns: 字符串的Bounds
   */
  func bounds(font: UIFont,size : CGSize) -> CGRect {
    let attributes = [NSFontAttributeName: font]
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    let rect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
    return rect
  }
  
  
  /// 获取字符串的Bounds
  ///
  /// - parameter font:    字体大小
  /// - parameter size:    字符串长宽限制
  /// - parameter margins: 头尾间距
  /// - parameter space:   内部间距
  ///
  /// - returns: 字符串的Bounds
  func size(with font: UIFont,
            size: CGSize,
            margins: CGFloat = 0,
            space: CGFloat = 0) -> CGSize {
    var bound = self.bounds(font: font, size: size)
    let rows = self.rows(font: font, width: size.width)
    bound.size.height += margins * 2
    bound.size.height += space * (rows - 1)
    return bound.size
  }
  
  /// 文本行数
  ///
  /// - Parameters:
  ///   - font: 字体
  ///   - width: 最大宽度
  /// - Returns: 行数
  func rows(font: UIFont,width: CGFloat) -> CGFloat {
    // 获取单行时候的内容的size
    let singleSize = (self as NSString).size(attributes: [NSFontAttributeName:font])
    // 获取多行时候,文字的size
    let textSize = self.bounds(font: font, size: CGSize(width: width, height: CGFloat(MAXFLOAT))).size
    // 返回计算的行数
    return ceil(textSize.height / singleSize.height);
  }
  
}

// MARK: - 私有方法
extension String {
  /// Emojis 过滤
  ///
  /// - Parameter isEmoji: 是否需要Emoji
  /// - Returns: 数组
  fileprivate func emojiFilter(isEmoji: Bool) -> [String.UnicodeScalarView.Iterator.Element] {
    return unicodeScalars.filter { (scalar) -> Bool in
      switch scalar.value {
      case 0x3030, 0x00AE, 0x00A9,
           0x1D000...0x1F77F,
           0x2100...0x27BF,
           0xFE00...0xFE0F,
           0x1F900...0x1F9FF:
        return isEmoji
      default: break
      }
      return !isEmoji
    }
  }
}


