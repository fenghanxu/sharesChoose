
//  GRNetWork.swift
//  EnvironmentConfiguration
//
//  Created by BigL055 on 16/7/25.
//  Copyright © 2016年 BigL.EnvironmentConfiguration.com. All rights reserved.
//

import UIKit
import Alamofire

class SPNetWork: NSObject {
  static let shared = SPNetWork()
  /// 网络状态管理者
  fileprivate let netStausManager: NetworkReachabilityManager? = NetworkReachabilityManager(host: "www.baidu.com")
    
    func stopAllRequests(){
        if #available(iOS 9.0, *) {
            SessionManager.default.session.getAllTasks(completionHandler: { (tasks) in
                tasks.forEach({ (sessionTask) in
                    sessionTask.cancel()
                })
            })
        }else{
            SessionManager.default.session.getTasksWithCompletionHandler({ (sessionDataTasks, sessionUploadTasks, sessionDownloadTasks) in
                sessionDataTasks.forEach({ (sessionTask) in
                    sessionTask.cancel()
                })
                sessionUploadTasks.forEach({ (sessionTask) in
                    sessionTask.cancel()
                })
                sessionDownloadTasks.forEach({ (sessionTask) in
                    sessionTask.cancel()
                })
                
            })
        }
    }
    
    /// 网络是否可用
    ///
    /// - returns: 网络是否可用
    func isAvailable() -> Bool {
        return netStausManager!.isReachable
    }
    
    /// 停止监控网络状态
    func stopMonitorNetwork() {
        netStausManager?.stopListening()
    }
}

