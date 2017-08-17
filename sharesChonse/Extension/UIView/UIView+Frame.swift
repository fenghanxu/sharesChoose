//
//  BLUIView + Frame.swift
//  BLLiveTelecast
//
//  Created by BigL055 on 16/6/20.
//  Copyright © 2016年 bigL.liveTelecast.com. All rights reserved.
//

import UIKit

// MARK: - 设置ViewFarme相关属性
extension UIView{

  /// view的x
  var x: CGFloat{
    get{ return frame.origin.x }
    set{ self.frame.origin.x = newValue }
  }

  /// view的y
  var y: CGFloat{
    get{ return frame.origin.y }
    set{ self.frame.origin.y = newValue }
  }

  /// view的宽度
  var width: CGFloat {
    get{ return self.frame.size.width }
    set{
      var frameCopy = frame
      frameCopy.size.width = newValue
      frame = frameCopy
    }
  }

  /// view的高度
  var height: CGFloat {
    get{ return self.frame.size.height }
    set{ var frameCopy = frame
      frameCopy.size.height = newValue
      frame = frameCopy
    }
  }
  
  /// view中心X值
  var centerX: CGFloat{
    get{ return self.center.x }
    set{ self.center = CGPoint(x: newValue, y: self.center.y) }
  }

  /// view中心Y值
  var centerY: CGFloat{
    get{ return self.center.y }
    set{ self.center = CGPoint(x: self.center.y, y: newValue) }
  }

  /// view的size
  var size: CGSize{
    get{ return self.frame.size }
    set{
      var frameCopy = frame
      frameCopy.size = newValue
      frame = frameCopy
    }
  }

  /// view的origin
  var origin: CGPoint {
    get{ return self.frame.origin }
    set{
      var frameCopy = frame
      frameCopy.origin = newValue
      frame = frameCopy
    }
  }
}
