//
//  SPWebImage.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/9/5.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit
import Kingfisher

typealias DownloadProgressBlock = ((_ receivedSize: Int64, _ totalSize: Int64) -> ())
typealias CompletionHandler = ((_ image: UIImage?,_ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) -> ())
typealias DownloadHandler = ((_ image: UIImage?,_ error: NSError?, _ url: URL?, _ imageURL: Data?) -> ())


class SPWebImage: NSObject {
  static let cache = SPWebImageCache.shared
  static let downloader = SPWebImageDownloader.shared
}

class SPWebImageDownloader {
  static let shared = SPWebImageDownloader()
  private let downloader = KingfisherManager.shared.downloader

  func download(urlStr: String,
                progresseCellBack: DownloadProgressBlock? = nil,
                completionHandler: DownloadHandler? = nil) {
    guard let url = URL(string: urlStr) else { return }
    
    downloader.downloadImage(with: url,
                             options: nil,
                             progressBlock: { (receivedSize, totalSize) in
                              progresseCellBack?(receivedSize,totalSize)
    }) { (image, error, url, data) in
      completionHandler?(image,error,url,data)
    }
  }
  
}

// MARK: - 内存相关
class SPWebImageCache {

  static let shared = SPWebImageCache()
  private let kingCache = KingfisherManager.shared.cache

  /// 清除内存缓存
   func clearMemoryCache() {
    kingCache.clearMemoryCache()
  }

  /// 清除磁盘缓存
   func clearDiskCache() {
    kingCache.clearDiskCache()
  }

  /// 获取磁盘图片缓存大小
  func getDiskBytes(diskBytes: @escaping (_ diskBytes:UInt) -> ()) {
    kingCache.calculateDiskCacheSize { (size) in
      diskBytes(size)
    }
  }

  /// 清洁过期缓存
   func cleanExpiredDiskCache() {
    kingCache.cleanExpiredDiskCache()
  }

  /// 设置最大磁盘缓存MB
   func setMaxDiskCacheSize(cacheSizeMB: UInt) {
    kingCache.maxDiskCacheSize = cacheSizeMB * 1024 * 1024
  }

  /// 设置最大过期时间 默认1周
   func setMaxCachePeriodInSecond(days: TimeInterval) {
    kingCache.maxCachePeriodInSecond = 60 * 60 * 24 * days
  }
}
