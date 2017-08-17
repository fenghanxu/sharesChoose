//
//  HXIconButton.swift
//  通知Demol
//
//  Created by iOS1002 on 2017/1/17.
//  Copyright © 2017年 iOS1002. All rights reserved.
//

import UIKit

class HXIconButton: UIButton {

  override func layoutSubviews() {
    super.layoutSubviews()
    /// 图片与文本交换
    //    titleLabel?.x = 0
    //    let width = (titleLabel?.width)! + 5
    //    imageView?.x = width

    imageView?.x = 0
    let width = (titleLabel?.width)! + 20
    titleLabel?.x = width
  }

}
