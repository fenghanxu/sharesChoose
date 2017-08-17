//
//  TopView.swift
//  B7iOSBuyer
//
//  Created by iOS1002 on 2017/4/10.
//  Copyright © 2017年 com.spzjs.b7iosbuy. All rights reserved.
//

import UIKit

protocol ShopAndGoodsDelegate: AnyObject {
  func shopAndGoods(view:ShopAndGoodsView, chooseBtn btn:UIButton)
}

class ShopAndGoodsView: UIView {

  weak var delegate: ShopAndGoodsDelegate?

  fileprivate let goodsBtn:UIButton = UIButton()
  fileprivate let shopsBtn:UIButton = UIButton()
  fileprivate let bottomLineView = UIView()
  fileprivate let moveLineView = UIView()
    
//这个属性书用于程序进来的术后给这个属性赋值的话可以设置滑动横条默认的位置在哪里的。不这设置默认就是第一个。
    var type: Int = 0{
        didSet{
            if type != oldValue {
                switch type {
                case 0:
                    goodsBtn.isSelected = true
                    shopsBtn.isSelected = false
                    self.moveLineView.frame = CGRect(x: 0 * SPScreenWidth * 0.5 + SPScreenWidth * 0.2, y: 37, width: SPScreenWidth * 0.1, height: 3)
                default:
                    goodsBtn.isSelected = false
                    shopsBtn.isSelected = true
                    self.moveLineView.frame = CGRect(x: 1 * SPScreenWidth * 0.5 + SPScreenWidth * 0.2, y: 37, width: SPScreenWidth * 0.1, height: 3)
                }
            }
        }
    }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = Color.white
    addSubview(goodsBtn)
    addSubview(shopsBtn)
    addSubview(bottomLineView)
    addSubview(moveLineView)
    buildUI()

  }

  fileprivate func buildUI() {
    buildSubView()
    buildLayout()
  }

  fileprivate func buildSubView() {
    goodsBtn.setTitle("商品", for: .normal)
    goodsBtn.setTitleColor(Color.black, for: .normal)
    goodsBtn.setTitleColor(Color.theme, for: .selected)
    goodsBtn.titleLabel?.font = Font.font14
    goodsBtn.addTarget(self, action: #selector(ShopAndGoodsView.goodsButtonClick), for: .touchUpInside)
    goodsBtn.isSelected = true
    goodsBtn.tag = 0

    shopsBtn.setTitle("档口", for: .normal)
    shopsBtn.setTitleColor(Color.black, for: .normal)
    shopsBtn.setTitleColor(Color.theme, for: .selected)
    shopsBtn.titleLabel?.font = Font.font14
    shopsBtn.addTarget(self, action: #selector(ShopAndGoodsView.shopButtonClick), for: .touchUpInside)
    shopsBtn.tag = 1

    bottomLineView.backgroundColor = Color.background
    moveLineView.backgroundColor = Color.theme

    self.moveLineView.frame = CGRect(x: 0 * SPScreenWidth * 0.5 + SPScreenWidth * 0.2, y: 37, width: SPScreenWidth * 0.1, height: 3)
  }

  fileprivate func buildLayout(){

    bottomLineView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalToSuperview()
      make.height.equalTo(1)
    }

    goodsBtn.snp.makeConstraints { (make) in
      make.bottom.equalTo(bottomLineView.snp.top)
      make.top.left.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.5)
    }

    shopsBtn.snp.makeConstraints { (make) in
      make.bottom.equalTo(bottomLineView.snp.top)
      make.top.right.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.5)
    }

  }

}

extension ShopAndGoodsView {

  func goodsButtonClick() {
    line(animate: 0.2, index: 0)
    goodsBtn.isSelected = true
    shopsBtn.isSelected = false
    delegate?.shopAndGoods(view: self, chooseBtn: goodsBtn)
  }

  func shopButtonClick() {
    line(animate: 0.2, index: 1)
    goodsBtn.isSelected = false
    shopsBtn.isSelected = true
    delegate?.shopAndGoods(view: self, chooseBtn: shopsBtn)
  }

  fileprivate func line(animate time: Double,index: Int){
    UIView.animate(withDuration: TimeInterval(time)) {
      self.moveLineView.frame = CGRect(x: index.cgFloat * SPScreenWidth * 0.5 + SPScreenWidth * 0.2, y: 37, width: SPScreenWidth * 0.1, height: 3)
    }
  }

}

