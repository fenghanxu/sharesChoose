//
//  NavMenuView.swift
//  全屏蒙版封装
//
//  Created by iOS1002 on 2016/12/27.
//  Copyright © 2016年 iOS1002. All rights reserved.
//

import UIKit

protocol NavMenuViewDelegate: AnyObject {
  func navMenuView(navMenuView: MaskView)
}

class NavMenuItem {
  var image = UIImage()
  var title = ""
}

class NavMenuView: MaskView {

  weak var delegate: NavMenuViewDelegate?

  let tableView = UITableView(frame: CGRect.zero, style: .plain)

  var viewItems = [NavMenuItem]()

  var items = [NavMenuItem](){
    didSet{
      dealItems()
      tableView.snp.updateConstraints { (make) in
        make.top.equalToSuperview().offset(64 + 5)
        make.right.equalToSuperview().offset(-10)
        make.width.equalTo(120)
        make.height.equalTo(items.count * 61)
      }
      tableView.reloadData()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    buildUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension NavMenuView{
  func dealItems() {
    viewItems.removeAll()
    for item in items{
      var popItem = NavMenuItem()
      popItem = item
      viewItems.append(popItem)
    }
  }
}

extension NavMenuView {

  fileprivate func buildUI() {
    addSubview(tableView)
    buildSubView()
    buildLayout()
  }

  fileprivate func buildSubView() {
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
    tableView.alwaysBounceHorizontal = false
    tableView.alwaysBounceVertical = false
    tableView.layer.cornerRadius = 5
    tableView.layer.masksToBounds = true
    tableView.separatorStyle = .none
    tableView.delegate = self
    tableView.dataSource = self
  }

  fileprivate func buildLayout(){
    tableView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(64 + 5)
      make.right.equalToSuperview().offset(-10)
      make.width.equalTo(120)
      make.height.equalTo(0.1)
    }
  }

}

extension NavMenuView: UITableViewDelegate,UITableViewDataSource{

  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return viewItems.count
  }

  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    if cell == nil {
      cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    }
    cell?.selectionStyle = .none
    cell?.contentView.layer.borderColor = UIColor.white.cgColor
    cell?.contentView.layer.borderWidth = 0.5
    cell?.imageView?.image = viewItems[indexPath.item].image
    cell?.textLabel?.text = viewItems[indexPath.item].title
    return cell!
  }

  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    switch indexPath.item {
    case 0:
      delegate?.navMenuView(navMenuView: self)
    default:
      break
    }
    endShow()
  }
}
