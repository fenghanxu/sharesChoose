//
//  SPBaseTableView.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/9/5.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit

class SPBaseTableView: UITableView {

  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
    separatorStyle = .none//隐藏分割线
    //不显示滚动条
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
