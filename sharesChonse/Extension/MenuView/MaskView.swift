//
//  MaskView.swift
//  全屏蒙版封装
//
//  Created by iOS1002 on 2016/12/27.
//  Copyright © 2016年 iOS1002. All rights reserved.
//

import UIKit

class MaskView: UIView {



  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.black.withAlphaComponent(0.5)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    endShow()
  }

  func show() {
    self.frame = UIScreen.main.bounds
    UIApplication.shared.keyWindow?.addSubview(self)
    UIView.animate(withDuration: 0.2, animations: {
      self.alpha = 1
    })
  }

  func endShow() {
    UIApplication.shared.keyWindow?.endEditing(true)
    UIView.animate(withDuration: 0.2, animations: {
      self.alpha = 0
    })

    SPGcd.sleep(0.2, mainQueueBlock: {
      self.removeFromSuperview()
    })

  }

}
