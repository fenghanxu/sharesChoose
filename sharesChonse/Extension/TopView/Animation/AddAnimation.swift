//
//  AddAnimation.swift
//  testAnimation
//
//  Created by 邵焕超 on 2017/2/14.
//  Copyright © 2017年 邵焕超. All rights reserved.
//

import UIKit

class AddAnimation: UIView {
  
 fileprivate var animStop: (()->())?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.isUserInteractionEnabled = false
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension AddAnimation {
  func animation(start: CGRect, end: CGPoint, image: UIImage, event: (()->())? = nil) {
    
    let window =  UIApplication.shared.keyWindow
    window?.addSubview(self)
    self.frame = CGRect(x: start.x, y: start.y, width: start.width, height: start.height)
    if image.size.width == 0 {
      backgroundColor = Color.random
    }else {
      self.image = image
    }
    
    // 路径
    let path = UIBezierPath()
    let movePoint = CGPoint(x: start.x + (self.bounds.width / 2), y: start.y + (self.bounds.height / 2))
    path.move(to: movePoint)
    let controlPoint2 = CGPoint(x: end.x , y: start.y )
    path.addCurve(to: end, controlPoint1: start.origin, controlPoint2: controlPoint2)
    // 曲线动画
    let animation = CAKeyframeAnimation(keyPath: "position")
    animation.path = path.cgPath
    animation.rotationMode = kCAAnimationRotateAuto
    // 缩放动画
    let scAnimation = CABasicAnimation(keyPath: "transform.scale")
    scAnimation.fromValue = 1
    scAnimation.toValue = 0.2
    scAnimation.autoreverses = true
    // 旋转动画
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotationAnimation.toValue = NSNumber(floatLiteral: M_PI * 11.0)
    rotationAnimation.duration = 1.5
    rotationAnimation.isCumulative = true
    rotationAnimation.repeatCount = 0
    
    // 组动画
    let group = CAAnimationGroup()
    group.animations = [animation, scAnimation, rotationAnimation]
    group.duration = 0.5
    group.isRemovedOnCompletion = false
    group.fillMode = kCAFillModeForwards
    group.delegate = self
    group.setValue("groupsAnimation", forKey: "addAnimation")
    self.layer.add(group, forKey: nil)
    
    self.animStop = event
  }
  
  func animation(start: CGRect, end: CGPoint, imageUrl: String, event: (()->())? = nil) {
    
    let window =  UIApplication.shared.keyWindow
    window?.addSubview(self)
    self.frame = CGRect(x: start.x, y: start.y, width: start.width, height: start.height)
    
    let imageView = UIImageView()
    addSubview(imageView)
    imageView.setImage(urlStr: imageUrl, placeholder: UIImage(named: "default-GoodDetail"))
    imageView.frame = CGRect(x: 0, y: 0, width: start.width, height: start.height)
    
    // 路径
    let path = UIBezierPath()
    let movePoint = CGPoint(x: start.x + (self.bounds.width / 2), y: start.y + (self.bounds.height / 2))
    path.move(to: movePoint)
    let controlPoint2 = CGPoint(x: end.x , y: start.y )
    path.addCurve(to: end, controlPoint1: start.origin, controlPoint2: controlPoint2)
    // 曲线动画
    let animation = CAKeyframeAnimation(keyPath: "position")
    animation.path = path.cgPath
    animation.rotationMode = kCAAnimationRotateAuto
    // 缩放动画
    let scAnimation = CABasicAnimation(keyPath: "transform.scale")
    scAnimation.fromValue = 1
    scAnimation.toValue = 0.2
    scAnimation.autoreverses = true
    // 旋转动画
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotationAnimation.toValue = NSNumber(floatLiteral: M_PI * 11.0)
    rotationAnimation.duration = 1.5
    rotationAnimation.isCumulative = true
    rotationAnimation.repeatCount = 0
    
    // 组动画
    let group = CAAnimationGroup()
    group.animations = [animation, scAnimation, rotationAnimation]
    group.duration = 0.5
    group.isRemovedOnCompletion = false
    group.fillMode = kCAFillModeForwards
    group.delegate = self
    group.setValue("groupsAnimation", forKey: "addAnimation")
    self.layer.add(group, forKey: nil)
    
    self.animStop = event
  }
}

extension AddAnimation: CAAnimationDelegate{
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    isHidden = true
    animStop?()
    removeFromSuperview()
  }
}


extension AddAnimation {
  func buildUI() {
    
  }
  func randColor() -> UIColor {
    return  UIColor(red: CGFloat(Double(arc4random_uniform(255))/255.0),
                    green: CGFloat(Double(arc4random_uniform(255))/255.0),
                    blue: CGFloat(Double(arc4random_uniform(255))/255.0), alpha: 1)
  }
}



