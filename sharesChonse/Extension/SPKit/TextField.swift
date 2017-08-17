//
//  TextField.swift
//  B7iOSShop
//
//  Created by 膳品科技 on 2016/11/26.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit


protocol TextFieldDelegate: AnyObject {
  /// 删除按钮事件回调
  ///
  /// - Parameter textField: textField
  func textField(deleteBackward textField: UITextField)
}

class TextField: UITextField {

  /// 键盘代理
  weak var inuptDelegate: TextFieldDelegate?

  override func deleteBackward() {
    super.deleteBackward()
    inuptDelegate?.textField(deleteBackward:self)
  }
  
}
