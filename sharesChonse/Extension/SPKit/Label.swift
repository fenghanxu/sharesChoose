//
//  SPLabel.swift
//  B7iOSBuyer
//
//  Created by BigL on 2016/12/29.
//  Copyright © 2016年 com.spzjs.b7iosbuy. All rights reserved.
//

import UIKit

class Label: UILabel {
  
  var textInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

  override func drawText(in rect: CGRect) {
    super.drawText(in: CGRect(x: bounds.origin.x + textInset.left,
                              y: bounds.origin.y + textInset.top,
                              width: bounds.size.width - textInset.left - textInset.right,
                              height: bounds.size.height - textInset.top - textInset.bottom))
  }

}
