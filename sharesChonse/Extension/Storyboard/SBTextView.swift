//
//  SPTextView.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/9/12.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit

class SBTextView: UITextView {
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
}
