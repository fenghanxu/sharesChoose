//
//  UIButton+Kingfisher.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/8/25.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit
import Kingfisher

extension UIButton {

  public var sp: UIButton {
    get { return self }
  }

  /// 设置网络图片
  ///
  /// - Parameters:
  ///   - urlStr: URL链接
  ///   - state: Button状态
  ///   - placeholderImage: 占位图片
  ///   - progresseCellBack: 下载进度回调
  ///   - completionHandler: 完成回调
  func setBackgroundImage(urlStr: String,
                          for state: UIControlState,
                          placeholder: UIImage? = nil,
                          progresseCellBack: DownloadProgressBlock? = nil,
                          completionHandler: CompletionHandler? = nil) {
    guard let url = URL(string: urlStr) else {
      SPLogs("url:|\(urlStr)|无法解析为URL类型")
      if let placeholder = placeholder{
        self.setBackgroundImage(placeholder, for: state)
      }
      return
    }
    kf.setBackgroundImage(with: url,
                          for: state,
                          placeholder: placeholder,
                          options: [.backgroundDecode],
                          progressBlock: { (receivedSize,totalSize) in
                            progresseCellBack?(receivedSize,totalSize)
    }, completionHandler: { (_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) in
      completionHandler?(image, error, cacheType, imageURL)
    })
  }

  /// 设置网络图片
  ///
  /// - Parameters:
  ///   - urlStr: URL链接
  ///   - state: Button状态
  ///   - placeholderImage: 占位图片
  ///   - progresseCellBack: 下载进度回调
  ///   - completionHandler: 完成回调
  func setImage(urlStr: String,
                for state: UIControlState,
                placeholder: UIImage? = nil,
                progresseCellBack: DownloadProgressBlock? = nil,
                completionHandler: CompletionHandler? = nil) {
    guard let url = URL(string: urlStr) else {
      SPLogs("url:|\(urlStr)|无法解析为URL类型")
      if let placeholder = placeholder{
        self.setImage(placeholder, for: state)
      }
      return
    }
    kf.setImage(with: url,
                for: state,
                placeholder: placeholder,
                options: [.backgroundDecode],
                progressBlock: { (receivedSize,totalSize) in
                  progresseCellBack?(receivedSize,totalSize)
    }, completionHandler: { (_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) in
      completionHandler?(image, error, cacheType, imageURL)
    })
  }
}
