//
// TableView+Empty.swift
// B7iOSShop
//
// Created by BigL on 2016/12/9.
// Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit
import SnapKit

protocol EmptyForTableViewDelegate: NSObjectProtocol {
  func emptyViewButtonEvent(btn: UIButton)
}

public class EmptyForTableView: UIView {
  
  weak var delegate: EmptyForTableViewDelegate?
  
  public var title: String = NullString
  public var icon: UIImage? = nil
  public var subTitle: String = NullString
  public var buttonTitle: String = NullString
  
   fileprivate(set) var iconImageView = UIImageView()
   fileprivate(set) var titleLabel = UILabel()
   fileprivate(set) var subTitleLabel = UILabel()
   fileprivate(set) var button = UIButton(type: .custom)
   fileprivate(set) var contentView = UIView(frame: CGRect.zero)
  
  public init(icon: UIImage,
              title: String,
              subTitle: String,
              buttonTitle: String) {
    self.icon = icon
    self.title = title
    self.subTitle = subTitle
    self.buttonTitle = buttonTitle
    super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    backgroundColor = Color.background
    buildContentView()
    buildLayout()
    buildIconImageView()
    buildTitleLabel()
    buildSubTitleLabel()
    buildButton()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func beginAnimation() {
   var images = [UIImage]()
    for index in 0...13 {
      guard let image = UIImage(named: "loading logo-" + index.string) else{
        continue
      }
      images.append(image.sp.reSize(size: CGSize(width: 200, height: 200)))
    }
    guard let image = UIImage.animatedImage(with: images, duration: 0.4) else{
    return
    }
    iconImageView.image = image
  }
  
  func endAnimation() {
    iconImageView.layer.removeAllAnimations()
  }

  
  func buttonEvent() {
    delegate?.emptyViewButtonEvent(btn: button)
  }
  
 private func buildContentView() {
    addSubview(contentView)
    contentView.addSubview(iconImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(subTitleLabel)
    contentView.addSubview(button)
  }
  
  private func buildIconImageView() {
    iconImageView.image = icon ?? UIImage()
  }
  
  private func buildTitleLabel() {
    titleLabel.numberOfLines = 0
    titleLabel.textAlignment = .center
    titleLabel.lineBreakMode = .byTruncatingTail
    titleLabel.textColor = Color.textBlack
    titleLabel.text = title
  }
  
  private func buildSubTitleLabel() {
    subTitleLabel.numberOfLines = 0
    subTitleLabel.textAlignment = .center
    subTitleLabel.lineBreakMode = .byTruncatingTail
    subTitleLabel.textColor = Color.textGray
    subTitleLabel.text = subTitle
  }
  
  
  private func buildButton() {
    button.isHidden = buttonTitle.isEmpty
    button.setBackgroundColor(color: Color.themeLight, for: .normal)
    button.setBackgroundColor(color: Color.themeLightDeep, for: .highlighted)
    button.setTitleColor(Color.white, for: .normal)
    button.titleLabel?.font = Font.font(ofSize: 18)
    button.addTarget(self, action:#selector(buttonEvent), for: .touchUpInside)
    button.setTitle(buttonTitle, for: .normal)
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 2
  }
  
  func buildLayout() {
    contentView.snp.makeConstraints {[weak self] (make) in
      guard let base = self else { return }
      make.left.right.equalToSuperview()
      make.top.equalTo(base.iconImageView)
      make.bottom.equalTo(base.button)
      make.center.equalToSuperview()
    }
    
    iconImageView.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.centerX.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints{[weak self] (make) in
      guard let base = self else { return }
      make.top.equalTo(base.iconImageView.snp.bottom).offset(10)
      make.width.lessThanOrEqualToSuperview().multipliedBy(0.8)
      make.centerX.equalToSuperview()
    }
    
    subTitleLabel.snp.makeConstraints {[weak self] (make) in
      guard let base = self else { return }
      make.top.equalTo(base.titleLabel.snp.bottom)
      make.width.lessThanOrEqualToSuperview().multipliedBy(0.8)
      make.centerX.equalToSuperview()
    }
    
    button.snp.makeConstraints {[weak self] (make) in
      guard let base = self else { return }
      make.top.equalTo(base.subTitleLabel.snp.bottom).offset(10)
      make.centerX.equalTo(base.contentView)
      make.size.equalTo(CGSize(width: 200, height: 40))
    }
  }
}
