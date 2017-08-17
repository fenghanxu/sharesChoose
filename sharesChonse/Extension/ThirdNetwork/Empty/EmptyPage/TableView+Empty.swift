//
//  TableView+Empty.swift
//  B7iOSShop
//
//  Created by BigL on 2016/12/9.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

public protocol UITableViewEmptyDelegate: NSObjectProtocol {
  func emptyView(for tableView:UITableView) -> UIView?
}

public protocol UITableViewEmptyDataSource: NSObjectProtocol{
  func emptyView(didSelect btn: UIButton)
}

public protocol UICollectionViewEmptyDelegate: NSObjectProtocol {
  func emptyView(for tableView: UICollectionView) -> UIView?
}

public protocol UICollectionViewEmptyDataSource: NSObjectProtocol{
  func emptyView(didSelect btn: UIButton)
}

extension UIScrollView {
  private static var once: Bool = false
  
  open override class func initialize() {
    if once == false {
      once = true
      RunTime.exchangeMethod(target: "reloadData",
                             replace: "table_emptyReloadData",
                             class: UITableView.self)
      RunTime.exchangeMethod(target: "reloadData",
                             replace: "coll_emptyReloadData",
                             class: UICollectionView.self)
    }
  }
}


extension UITableView: EmptyForTableViewDelegate{
  
  private struct EmptyDataKey {
    static let dataSourceKey = UnsafeRawPointer.init(bitPattern: "table_dataSourceKey".hashValue)
    static let delegateKey   = UnsafeRawPointer.init(bitPattern: "table_delegateKey".hashValue)
    static let emptyViewKey  = UnsafeRawPointer.init(bitPattern: "table_emptyViewKey".hashValue)
    static let emptyViewType = UnsafeRawPointer.init(bitPattern: "table_emptyViewType".hashValue)
  }
  
  weak var emptyDelegate: UITableViewEmptyDelegate? {
    get {
      return objc_getAssociatedObject(self,
                                      UITableView.EmptyDataKey.delegateKey) as? UITableViewEmptyDelegate
    }set{
      if let delegate: AnyObject = newValue as AnyObject? {
        objc_setAssociatedObject(self,
                                 UITableView.EmptyDataKey.delegateKey,
                                 delegate,
                                 .OBJC_ASSOCIATION_ASSIGN)
      }
    }
  }
  
  
  weak var emptyDataSource: UITableViewEmptyDataSource? {
    get {
      return objc_getAssociatedObject(self,
                                      UITableView.EmptyDataKey.dataSourceKey) as? UITableViewEmptyDataSource
    }set{
      if let dataSource: AnyObject = newValue {
        objc_setAssociatedObject(self,
                                 UITableView.EmptyDataKey.dataSourceKey,
                                 dataSource,
                                 .OBJC_ASSOCIATION_ASSIGN)
      }
    }
  }
  
  private var emptyView: UIView? {
    get {
      return objc_getAssociatedObject(self,
                                      UITableView.EmptyDataKey.emptyViewKey) as? UIView
    }set {
      if let emptyView: AnyObject = newValue {
        objc_setAssociatedObject(self,
                                 UITableView.EmptyDataKey.emptyViewKey,
                                 emptyView,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
  
  var emptyType: EmptyPage.PageType {
    get {
      return objc_getAssociatedObject(self,
                                      UITableView.EmptyDataKey.emptyViewType) as? EmptyPage.PageType ?? .unknown
    }set {
      objc_setAssociatedObject(self,
                               UITableView.EmptyDataKey.emptyViewType,
                               newValue,
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  public func emptyView(icon: UIImage?,
                        title: String?,
                        subTitle: String?,
                        buttonTitle: String?) ->UIView? {
    
    let view = EmptyForTableView(icon: icon ?? UIImage(),
                                 title: title ?? NullString,
                                 subTitle: subTitle ?? NullString,
                                 buttonTitle: buttonTitle ?? NullString)
    
    view.delegate = self
    return view
  }
  
  func emptyView(type: EmptyPage.PageType) ->EmptyPage? {
    let view = EmptyPage(type: type)
    view.delegate = self
    return view
  }
  
  func emptyViewButtonEvent(btn: UIButton) {
    emptyDataSource?.emptyView(didSelect: btn)
  }
  
  func table_emptyReloadData() {
    let con_0 = emptyDelegate == nil
    let con_1 = emptyType == .unknown
    let con_2 = frame.size.width * frame.size.height == 0
    if con_2{
      self.table_emptyReloadData()
      return
    }
    
    if con_0 && con_1 {
      self.table_emptyReloadData()
      return
    }
    
    guard let dataSource = dataSource else { return }
    let sectionCount = dataSource.numberOfSections?(in: self) ?? 1
    
    var rowCount = 0
    for index in 0 ..< sectionCount {
      rowCount += dataSource.tableView(self, numberOfRowsInSection: index)
    }
    
    switch rowCount {
    case 0:
      isScrollEnabled = false
      if self.emptyView != nil { emptyView?.removeFromSuperview() }
      if emptyType != .unknown {
        emptyView = emptyView(type: emptyType)
      }
      if let emptyDelegate = emptyDelegate {
        emptyView = emptyDelegate.emptyView(for: self)
      }
      guard let emptyView: UIView = emptyView else { return }
      emptyView.frame = CGRect(x: 0, y: 0, width: width, height: height)
      addSubview(emptyView)
    default:
      self.isScrollEnabled = true
      if emptyView != nil { emptyView?.removeFromSuperview() }
    }
    self.table_emptyReloadData()
  }
}


extension UICollectionView: EmptyForTableViewDelegate{
  
  private struct EmptyDataKey {
    static let dataSourceKey = UnsafeRawPointer.init(bitPattern:"coll_dataSourceKey".hashValue)
    static let delegateKey   = UnsafeRawPointer.init(bitPattern:"coll_delegateKey".hashValue)
    static let emptyViewKey  = UnsafeRawPointer.init(bitPattern:"coll_emptyViewKey".hashValue)
    static let emptyViewType = UnsafeRawPointer.init(bitPattern:"coll_emptyViewType".hashValue)
  }
  
  weak var emptyDelegate: UICollectionViewEmptyDelegate? {
    get {
      return objc_getAssociatedObject(self,
                                      UICollectionView.EmptyDataKey.delegateKey) as? UICollectionViewEmptyDelegate
    }set{
      if let delegate:AnyObject = newValue as AnyObject? {
        objc_setAssociatedObject(self,
                                 UICollectionView.EmptyDataKey.delegateKey,
                                 delegate,
                                 .OBJC_ASSOCIATION_ASSIGN)
      }
    }
  }
  
  weak var emptyDataSource: UICollectionViewEmptyDataSource? {
    get {
      return objc_getAssociatedObject(self,
                                      UICollectionView.EmptyDataKey.dataSourceKey) as? UICollectionViewEmptyDataSource
    }set{
      if let dataSource: AnyObject = newValue {
        objc_setAssociatedObject(self,
                                 UICollectionView.EmptyDataKey.dataSourceKey,
                                 dataSource,
                                 .OBJC_ASSOCIATION_ASSIGN)
      }
    }
  }
  
  private var emptyView: UIView? {
    get {
      return objc_getAssociatedObject(self,
                                      UICollectionView.EmptyDataKey.emptyViewKey) as? UIView
    }set {
      if let emptyView: AnyObject = newValue {
        objc_setAssociatedObject(self,
                                UICollectionView.EmptyDataKey.emptyViewKey,
                                 emptyView,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
  
  var emptyType: EmptyPage.PageType {
    get {
      return objc_getAssociatedObject(self,
                                      UICollectionView.EmptyDataKey.emptyViewType) as? EmptyPage.PageType ?? .unknown
    }set {
      objc_setAssociatedObject(self,
                               UICollectionView.EmptyDataKey.emptyViewType,
                               newValue,
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  
  public func emptyView(icon: UIImage?,
                        title: String?,
                        subTitle: String?,
                        buttonTitle: String?) ->UIView? {
    
    let view = EmptyForTableView(icon: icon ?? UIImage(),
                                 title: title ?? NullString,
                                 subTitle: subTitle ?? NullString,
                                 buttonTitle: buttonTitle ?? NullString)
    
    view.delegate = self
    return view
  }
  
  func emptyView(type: EmptyPage.PageType) ->EmptyPage? {
    let view = EmptyPage(type: type)
    view.delegate = self
    return view
  }
  
  func emptyViewButtonEvent(btn: UIButton) {
    emptyDataSource?.emptyView(didSelect: btn)
  }
  
  func coll_emptyReloadData() {
    let con_0 = emptyDelegate == nil
    let con_1 = emptyType == .unknown
    let con_2 = frame.size.width * frame.size.height == 0
    
    if con_2{
      self.coll_emptyReloadData()
      return
    }
    
    if con_0 && con_1 {
      self.coll_emptyReloadData()
      return
    }
    
    guard let dataSource = dataSource else { return }
    let sectionCount = dataSource.numberOfSections?(in: self) ?? 1
    
    var rowCount = 0
    for index in 0 ..< sectionCount {
      rowCount += dataSource.collectionView(self, numberOfItemsInSection: index)
    }
    
    switch rowCount {
    case 0:
      isScrollEnabled = false
      removedEmptyView()
      if emptyType != .unknown {
        emptyView = emptyView(type: emptyType)
      }
      if let emptyDelegate = emptyDelegate {
        emptyView = emptyDelegate.emptyView(for: self)
      }
      guard let emptyView: UIView = emptyView else { return }
      emptyView.frame = CGRect(x: 0, y: 0, width: width, height: height)
      addSubview(emptyView)
    default:
      self.isScrollEnabled = true
      removedEmptyView()
    }
    self.coll_emptyReloadData()
  }
  
  
  func removedEmptyView() {
    if emptyView != nil {
      UIView.animate(withDuration: 0.2, animations: {
        self.emptyView?.alpha = 0
      })
      emptyView?.removeFromSuperview()
    }
  }
}

