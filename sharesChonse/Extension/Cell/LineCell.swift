//
//  NormalCell.swift
//  B7iOSBuyer
//
//  Created by BigL on 2017/2/8.
//  Copyright © 2017年 com.spzjs.b7iosbuy. All rights reserved.
//

import UIKit

class LineCell: UITableViewCell {

  fileprivate let topLine = UIView()
  fileprivate let botLine = UIView()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    buildUI()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    buildUI()
  }
    
   //隐藏顶部的分割线  true  隐藏    false 显示
  func topLine(isHidden: Bool) {
    topLine.isHidden = isHidden
  }

  //移除顶部的分割线  true 移除    false  显示
  func topLine(isRemove: Bool) {
    if isRemove{
      topLine.removeFromSuperview()
    }else{
      if topLine.superview != nil { return }
      addSubview(topLine)
      topLine.snp.makeConstraints { (make) in
        make.top.right.equalToSuperview()
        make.left.equalToSuperview().offset(15)
        make.height.equalTo(1)
      }
    }
  }
  //顶部线的长度跟颜色
  func topLine(inset: CGFloat,color: UIColor = Color.line) {
    if topLine.superview == nil { return }
    topLine.backgroundColor = color
    topLine.snp.updateConstraints { (make) in
      make.left.equalToSuperview().offset(inset)
    }
  }

  func botLine(isHidden: Bool) {
    botLine.isHidden = isHidden
  }

  func botLine(isRemove: Bool) {
    if isRemove{
      botLine.removeFromSuperview()
    }else{
      if botLine.superview != nil { return }
      addSubview(botLine)
      botLine.snp.makeConstraints { (make) in
        make.bottom.right.equalToSuperview()
        make.left.equalToSuperview().offset(15)
        make.height.equalTo(1)
      }
    }
  }

  func botLine(inset: CGFloat,color: UIColor = Color.line) {
    if botLine.superview == nil { return }
    botLine.backgroundColor = color
    botLine.snp.updateConstraints { (make) in
      make.left.equalToSuperview().offset(inset)
    }
  }

  fileprivate func buildUI() {
    selectionStyle = .none
    contentView.addSubview(topLine)
    contentView.addSubview(botLine)
    buildLayout()
    buildSubView()
  }

  private func buildLayout() {
    botLine.snp.makeConstraints { (make) in
      make.bottom.right.equalToSuperview()
      make.left.equalToSuperview().offset(15)
      make.height.equalTo(1)
    }

    topLine.snp.makeConstraints { (make) in
      make.top.right.equalToSuperview()
      make.left.equalToSuperview().offset(15)
      make.height.equalTo(1)
    }
  }

  private func buildSubView() {
    topLine.isUserInteractionEnabled = false
    botLine.isUserInteractionEnabled = false
    topLine.backgroundColor = Color.line
    botLine.backgroundColor = Color.line
  }

}
