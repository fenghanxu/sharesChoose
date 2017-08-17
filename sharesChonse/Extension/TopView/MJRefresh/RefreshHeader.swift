//
//  SPGifRefreshView.swift
//  B7iOS
//
//  Created by BigL on 16/8/22.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

/*
 使用
 tableView.refreshHeader = RefreshHeader.gifHeader(target: self,
 action: #selector(refreshData))
 
 处理方法
 func refreshData() {
 tableView.refreshHeader.endRefreshing()
 }
 
 成不成功都要停止
 tableView.refreshHeader.endRefreshing()
 */
import UIKit
import MJRefresh

class RefreshHeader: MJRefreshGifHeader {

  class func gifHeader(target: AnyObject,
                       action: Selector) -> MJRefreshGifHeader{

    let header : RefreshHeader = RefreshHeader(refreshingTarget: target, refreshingAction: action)
    header.height = SPNavBarHeight
    return header
  }

  /// 空白刷新
  ///
  /// - parameter refreshingTarget: 目标控制器
  /// - parameter refreshingAction: 目标方法
  ///
  /// - returns: 刷新头
  class func blankHeader(target: AnyObject,
                         action: Selector) -> MJRefreshGifHeader{
    let header: MJRefreshGifHeader = MJRefreshGifHeader(refreshingTarget: target, refreshingAction: action)
    header.height = SPNavBarHeight
    header.lastUpdatedTimeLabel.isHidden = true
    header.stateLabel.isHidden = true
    return header
  }

  override func prepare() {
    super.prepare()

    var imagesA = [UIImage]()
    var imagesB = [UIImage]()
    var imagesC = [UIImage]()
    for index in 0...9 {
      let image = UIImage(named: "RefreshGif-\(index)")!
      let reImage = image.sp.reSize(size: CGSize(width: SPScreenWidth, height: SPNavBarHeight))
      imagesA.append(reImage)
    }
    for index in 10...13 {
      let image = UIImage(named: "RefreshGif-\(index)")!
      let pullImage = image.sp.reSize(size: CGSize(width: SPScreenWidth, height: SPNavBarHeight))
      imagesB.append(pullImage)
    }
    for index in 14...24 {
      let image = UIImage(named: "RefreshGif-\(index)")!
      let idleImage = image.sp.reSize(size: CGSize(width: SPScreenWidth, height: SPNavBarHeight))
      imagesC.append(idleImage)
    }

    imagesC = imagesC + imagesA

    self.setImages(imagesA, duration: 0.5, for: MJRefreshState.idle)
    self.setImages(imagesB, duration: 0.5, for: MJRefreshState.pulling)
    self.setImages(imagesC, duration: 2.0, for: MJRefreshState.refreshing)
    self.lastUpdatedTimeLabel.isHidden = true
    self.stateLabel.isHidden = true
  }


  /**
   在这里设置子控件的位置和尺寸
   */
  override func placeSubviews() {
    super.placeSubviews()

    self.gifView.contentMode = UIViewContentMode.center
    self.gifView.frame = CGRect.init(x: 0, y: 0, width: self.width, height: self.height)
  }
  
}
