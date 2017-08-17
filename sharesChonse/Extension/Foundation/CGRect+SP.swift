//
//  CGRect+SP.swift
//  B7iOSShop
//
//  Created by BigL on 2016/11/15.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

extension CGRect {
  
  /// X
  public var x: CGFloat {
    get { return self.origin.x }
    set(value) { self.origin.x = value }
  }
  
  /// Y
  public var y: CGFloat {
    get { return self.origin.y }
    set(value) { self.origin.y = value }
  }
  
  /// Width
  public var width: CGFloat {
    get { return self.size.width }
    set(value) { self.size.width = value }
  }
  
  /// Height
  public var height: CGFloat {
    get { return self.size.height }
    set(value) { self.size.height = value }
  }
  
}
