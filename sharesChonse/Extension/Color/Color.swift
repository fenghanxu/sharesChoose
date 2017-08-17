//
//  CustomColor.swift
//  EnvironmentConfiguration
//
//  Created by BigL055 on 16/7/25.
//  Copyright © 2016年 BigL.EnvironmentConfiguration.com. All rights reserved.
//

import UIKit

class Color: NSObject {

}

// MARK: - AS Swift3.0 Style
extension Color {
  /// 背景色
  class var background: UIColor { get{ return UIColor(value: 0xf4f4f4) } }
  
  /// 主题色,图标/按钮
  class var theme: UIColor { get{ return UIColor(value: 0x78885b) } }
  /// 主题深色
  class var themeDeep: UIColor { get{ return UIColor(value: 0x6d7b52) } }
  /// 主题浅色
  class var themeLight: UIColor { get{ return UIColor(value: 0x82A542) } }
  /// 主题浅色的深色
  class var themeLightDeep: UIColor { get{ return UIColor(value: 0x75953C) } }
  
  /// 辅助颜色
  class var assist: UIColor { get{ return UIColor(value: 0xffac03) } }
  /// 辅助深色
  class var assistDeep: UIColor { get{ return UIColor(value: 0xeabf30) } }
  /// 辅助浅色
  class var assistLight: UIColor { get{ return UIColor(value: 0xffac03) } }
  
  /// 主要文字
  class var textBlack: UIColor { get{ return UIColor(value: 0x333333) } }
  /// 次要文字
  class var textGray: UIColor { get{ return UIColor(value: 0x929292) } }
  /// 文字描边
  class var textLine: UIColor { get{ return UIColor(value: 0xdddddd) } }
  /// 价格
  class var price: UIColor { get{ return UIColor(value: 0xff5000) } }
  
  /// 阴影线
  class var line: UIColor { get{ return UIColor(value: 0xe5e5e5) } }
  /// 未激活按钮
  class var nonActivated: UIColor { get{ return UIColor(value: 0xbebebe) } }
  /// 导航条颜色
  class var navigationBar: UIColor { get{ return UIColor(value: 0xF7F7F7) } }
}

// MARK: - AS UIColor 3.0
extension Color {
  /// 黑
  class var black: UIColor { get{ return UIColor(value: 0x181916) } }
  /// 白
  class var white: UIColor { get{ return UIColor.white } }
  /// 透明
  class var clear: UIColor { get{ return UIColor.clear } }
  /// 随机色
  class var random: UIColor { get{ return UIColor.random } }
  
  class var yellow: UIColor { get{ return UIColor(value: 0xeabf30) } }

  
}
