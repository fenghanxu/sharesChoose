//
//  UIImageView+Extension.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/8/22.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit
import Kingfisher

var imageDict = [String:String]()

extension UIImageView {

  public var sp: UIImageView {
    get { return self }
  }

  /// 设置网络图片
  ///
  /// - Parameters:
  ///   - urlStr: URL链接
  ///   - placeholder: 占位图
  ///   - progresseCellBack: 下载进度回调
  ///   - completionHandler: 完成回调
  func setImage(urlStr: String,
                placeholder: UIImage = UIImage(),
                progresseCellBack: DownloadProgressBlock? = nil,
                completionHandler: CompletionHandler?) {
    guard let url = URL(string: urlStr) else {
      SPLogs("url:|\(urlStr)|无法解析为URL类型")
      self.image = placeholder
      return
    }
    kf.setImage(with: url,
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
  ///   - placeholder: 占位图
  func setImage(urlStr: String,
                placeholder: UIImage? = nil) {
    guard let url = URL(string: urlStr) else {
      SPLogs("url:|\(urlStr)|无法解析为URL类型")
      if let placeholder = placeholder{
        self.image = placeholder
      }
      return
    }
    kf.setImage(with: url,
                placeholder: placeholder,
                options: [.backgroundDecode],
                progressBlock: nil,
                completionHandler: nil)
  }
}
