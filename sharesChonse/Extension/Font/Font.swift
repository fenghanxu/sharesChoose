//
//  Font.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/8/19.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit

class Font: NSObject {

  /// 字体设置
  class func font(ofSize size: CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
  }

  class var font10: UIFont { get{ return UIFont.systemFont(ofSize: 10) } }
  class var font11: UIFont { get{ return UIFont.systemFont(ofSize: 11) } }
  class var font12: UIFont { get{ return UIFont.systemFont(ofSize: 12) } }
  class var font13: UIFont { get{ return UIFont.systemFont(ofSize: 13) } }
  class var font14: UIFont { get{ return UIFont.systemFont(ofSize: 14) } }
  class var font15: UIFont { get{ return UIFont.systemFont(ofSize: 15) } }
  class var font16: UIFont { get{ return UIFont.systemFont(ofSize: 16) } }
  class var font17: UIFont { get{ return UIFont.systemFont(ofSize: 17) } }
  class var font18: UIFont { get{ return UIFont.systemFont(ofSize: 18) } }
  class var font19: UIFont { get{ return UIFont.systemFont(ofSize: 19) } }
  class var font20: UIFont { get{ return UIFont.systemFont(ofSize: 20) } }
  class var font50: UIFont { get{ return UIFont.systemFont(ofSize: 50) } }

}
extension Font {
  /// 字体高度
  class var fontHeight15: CGFloat { get{ return 12 } }

}
