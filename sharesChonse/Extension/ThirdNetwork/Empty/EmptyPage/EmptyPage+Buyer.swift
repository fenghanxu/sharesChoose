//
//  Empty.swift
//  B7iOSBuy
//
//  Created by BigL on 2016/12/15.
//  Copyright © 2016年 www.spzjs.com. All rights reserved.
//

import UIKit

class EmptyPage: EmptyForTableView {
  
  /// 空白页类型
  ///
  /// - Address:      地址
  /// - Ticket:       优惠券
  /// - Like:         关注
  /// - Notification: 通知
  /// - Order:        订单内
  /// - outService:   不在配送范围内
  /// - ShopCart:     购物车
  enum PageType: Int {
    case noMarket
    case noShop
    case categoryWithoutGoods
    case categoryWithoutClass
    case address
    case ticket
    case like
    case message
    case order
    case integral
    case cashDetail
    case outService
    case shopCart
    case shopList
    case orderDetail
    case wait
    case noNetwork
    case unknown
  }
  
  init(type: EmptyPage.PageType) {
    var type = type
    var image: UIImage?
    var title = NullString
    var subTitle = NullString
    var btnTitle = NullString
    
    if !NetWork.isAvailable() { type = .noNetwork }
    switch type {
    case .noMarket:
      image = UIImage(named: "empty-out-of-service-area")
      title = "暂时未开通附近市场"
      subTitle = "切换地址试试?"
      btnTitle = "去切换"
    case .noShop:
      image = UIImage(named: "empty-out-of-service-area")
      title = "暂无档口入驻"
      subTitle = "切换市场试试?"
    case .categoryWithoutGoods:
      title = "暂时没有商品"
    case .categoryWithoutClass:
      image = UIImage(named: "empty-out-of-service-area")
      title = "暂时未开通附近市场"
    case .address:
      image = UIImage(named: "empty-address")
      title = "最遥远的距离是没有您的地址"
    case .ticket:
      image = UIImage(named: "empty-coupon")
      title = "优惠君还没到家..."
    case .like:
      image = UIImage(named: "empty-favorite")
      title = "您暂时没有收藏"
      btnTitle = "去逛逛"
    case .message:
      title = "什么通知？在哪?"
    case .order:
      image = UIImage(named: "empty-order")
      title = "矮油，没有订单"
      btnTitle = "刷新试试"
    case .integral:
      image = UIImage(named: "empty-order")
      title = "暂无积分"
    case .cashDetail:
      image = UIImage(named: "empty-order")
      title = "暂无明细"
    case .outService:
      title = "对不起"
      btnTitle = "更改位置"
    case .shopCart:
      image = UIImage(named: "empty-shopping-car")
      title = "还没有商品"
      btnTitle = "去逛逛"
    case .shopList:
      title = "档主正在努力上架商品"
    case .orderDetail:
      image = UIImage(named: "empty-order")
      title = "没有订单信息"
      btnTitle = "刷新试试"
    case .noNetwork:
      image = UIImage(named: "empty-wifi")
      title = "无网络服务"
      subTitle = "请检查网络状态"
    case .wait: break
    case .unknown: break
    }
    if image != nil {
      image = image!.sp.reSize(size: CGSize(width: 200, height: 200))
    }
    super.init(icon: image ?? UIImage(),
               title: title,
               subTitle: subTitle,
               buttonTitle: btnTitle)
    
    switch type {
    case .wait:
      beginAnimation()
    default:
      endAnimation()
    }
    
  }
  
  required internal init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
