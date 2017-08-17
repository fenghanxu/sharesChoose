//
//  SPTextField.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/9/12.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit


protocol SBTextFieldDelegate: AnyObject {
  func textField(deleteBackward textField: UITextField)
}

class SBTextField: UITextField {
  
 weak var inuptDelegate: SBTextFieldDelegate?

  override func deleteBackward() {
    super.deleteBackward()
    inuptDelegate?.textField(deleteBackward: self)
  }
  
  //圆角
  @IBInspectable var SBCornerRadius:CGFloat = 0.0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
      self.layer.masksToBounds = true
    }
  }
  //边框宽度
  @IBInspectable var SBBorderWidth:CGFloat = 0.0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }

  //边框颜色
  @IBInspectable var SBorderColor:UIColor = UIColor() {
    didSet {
      self.layer.borderColor = borderColor.cgColor
    }
  }

  /// 占位文字颜色
  @IBInspectable var PlaceTextColor: UIColor? {
    get {
      return self.placeHolderColor
    }
    set {
      self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                      attributes:[NSForegroundColorAttributeName: newValue!])
    }
  }

  /// 左右间距
  @IBInspectable var Padding: CGFloat = 0{
    didSet{
      self.leftView?.frame.size.width = Padding
      self.rightView?.frame.size.width = Padding
    }
  }

  /// 光标颜色
  @IBInspectable var TintsColor: UIColor = UIColor() {
    didSet {
      self.tintColor = TintsColor
    }
  }

  /// 左间距
  @IBInspectable var PaddingLeft:CGFloat {
    get {
      if let leftView = leftView {
        return leftView.frame.size.width
      } else {
        return 0
      }
    } set {
      leftViewMode = .always
      leftView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
    }
  }
  
  
  
}
