//
//  NetWork.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/8/9.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit

class NetWork: NSObject {
    
    /// 单例对象
    static let shared = NetWork()
    
    /// 网络是否可用
    class func isAvailable() -> Bool {
        return SPNetWork.shared.isAvailable()
    }
    
    class func stopRequests()  {
        SPNetWork.shared.stopAllRequests()
    }
    
    /// 网络是否可用
    func isAvailable() -> Bool {
        return SPNetWork.shared.isAvailable()
    }
    
    func stopRequests()  {
        SPNetWork.shared.stopAllRequests()
    }
    
}

