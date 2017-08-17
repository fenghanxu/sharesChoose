//
//  SPGcd.swift
//  B7iOSBuy
//
//  Created by 膳品科技 on 16/9/24.
//  Copyright © 2016年 www.spzjs.com. All rights reserved.
//

import UIKit

class SPGcd: NSObject {
  /// 线程延时
  class func sleep(_ time: Double,mainQueueBlock:@escaping ()->()) {
    let time = DispatchTime.now() + .milliseconds(Int(time * 1000))
    DispatchQueue.main.asyncAfter(deadline: time) {
      mainQueueBlock()
    }
  }
}

extension DispatchTime: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    self = DispatchTime.now() + .seconds(value)
  }
}

extension DispatchTime: ExpressibleByFloatLiteral {
  public init(floatLiteral value: Double) {
    self = DispatchTime.now() + .milliseconds(Int(value * 1000))
  }
}
