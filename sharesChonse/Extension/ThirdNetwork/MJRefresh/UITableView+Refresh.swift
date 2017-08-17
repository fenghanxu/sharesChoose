//
//  UITableView+SP.swift
//  B7iOSShop
//
//  Created by 膳品科技 on 2016/11/28.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit
import MJRefresh

extension UITableView {

  var refreshHeader: MJRefreshHeader {
    set{ self.mj_header = newValue }
    get{ return self.mj_header }
  }

}
