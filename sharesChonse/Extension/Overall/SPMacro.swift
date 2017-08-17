//
//  MacroSwift.swift
//  EnvironmentConfiguration
//
//  Created by 膳品科技 on 16/7/27.
//  Copyright © 2016年 BigL.EnvironmentConfiguration.com. All rights reserved.
//

import UIKit

/// 获取通知中心
public let SPNotification = NotificationCenter.default

/// 获取UIApplication单例对象
public let SPApplication = UIApplication.shared
public let SPKeyWindow = UIApplication.shared.keyWindow
public let SPRootVC = UIApplication.shared.keyWindow?.rootViewController

// MARK: - 全局常用属性
public let SPScreenBound: CGRect = UIScreen.main.bounds
public let SPScreenWidth: CGFloat = UIScreen.main.bounds.width
public let SPScreenHeight: CGFloat = UIScreen.main.bounds.height
public let SPStatusHeight: CGFloat = 20
public let SPNavBarHeight: CGFloat = 44
public let SPTabbarHeight: CGFloat = 49
public let SPStatusAndNavBarHeight : CGFloat = 64

// 间距
public let Space0: CGFloat = 0
public let Space1: CGFloat = 1
public let Space2: CGFloat = 2
public let Space3: CGFloat = 3
public let Space4: CGFloat = 4
public let Space5: CGFloat = 5
public let Space6: CGFloat = 6
public let Space7: CGFloat = 7
public let Space8: CGFloat = 8
public let Space9: CGFloat = 9
public let Space10: CGFloat = 10
public let Space11: CGFloat = 11
public let Space12: CGFloat = 12
public let Space13: CGFloat = 13
public let Space14: CGFloat = 14
public let Space15: CGFloat = 15
public let Space16: CGFloat = 16
public let Space17: CGFloat = 17
public let Space18: CGFloat = 18
public let Space19: CGFloat = 19
public let Space20: CGFloat = 20
public let Space25: CGFloat = 25
public let Space30: CGFloat = 30
public let Space35: CGFloat = 35
public let Space40: CGFloat = 40
public let Space45: CGFloat = 45
public let Space50: CGFloat = 50

public let Space55: CGFloat = 55
public let Space60: CGFloat = 60
public let Space64: CGFloat = 64
public let Space65: CGFloat = 65
public let Space70: CGFloat = 70
public let Space75: CGFloat = 75
public let Space80: CGFloat = 80
public let Space85: CGFloat = 85
public let Space90: CGFloat = 90
public let Space95: CGFloat = 95

public let Space100: CGFloat = 100
public let Space150: CGFloat = 150
public let Space200: CGFloat = 200
public let Space250: CGFloat = 250
public let Space300: CGFloat = 300
public let Space350: CGFloat = 350
public let Space400: CGFloat = 400
public let Space450: CGFloat = 450
public let Space500: CGFloat = 500

/// 比例
public let Scale16x9: CGFloat = 16/9
public let Scale16x6: CGFloat = 16/6
public let Scale4x3: CGFloat = 4/3
public let Scale3x1: CGFloat = 3
public let ScaleBest: CGFloat = 0.618

public var ShopCartAmount: Int = 0

/// 相应cell高度
public let SPGoodCellHeight : CGFloat = SPScreenWidth / Scale16x6

/**
 将数据写入桌面
 - parameter data:     要写入的数据
 - parameter filename: 文件名
 - returns: 是否写入成功
 */
public func SPWriterToDesktop(_ data : AnyObject?, filename : String,Type : String) -> Bool {
    return  (data?.write(toFile: String(format: "/Users/shanpinkeji/Desktop/\(filename).\(Type)"), atomically: true))!
}

