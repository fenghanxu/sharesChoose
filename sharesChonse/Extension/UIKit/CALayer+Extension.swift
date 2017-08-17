//
//  CALayer+Extension.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/9/9.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit

extension CALayer {
/*
 //平时不用这个文件是这样写的
 redBtn.layer.borderColor = Color.nonActivated.cgColor
 //下面的代码的作用
 redBtn.borderColor = Color.price
 */
  public var borderUIColor:UIColor? {
    set(newValue) {
      self.borderColor = newValue?.cgColor
    }
    get {
      return UIColor(cgColor: self.borderColor!)
    }
  }
  
}


