//
//  FHYYCache.swift
//  Demol
//
//  Created by 冯汉栩 on 2017/7/3.
//  Copyright © 2017年 hanxuFeng. All rights reserved.
//

/*
如：下面的代码封装只是个举例而已，具体想存什么还需要自己的根据下面的参考添加代码？
 获取数组
 list = FHYYCache.shared.searchHistories
 
 添加值
 FHYYCache.shared.searchHistories(append: searchList[count])
 
 删除单个值
 FHYYCache.shared.searchHistories(remove: self.list[indexPath.item])
 
 删除全部值
 FHYYCache.shared.searchHistoriesRemoveAll()
 
*/

import UIKit
import YYCache

class FHYYCache: NSObject {
    
    static let shared = FHYYCache()
    
    fileprivate let cache = YYCache(name: "FHYYCache")
    
    fileprivate enum Label: String {
        
        case searchHistory = "kSearchHistory"
        // 用户名称
        case userName = "kUserName"
        
        var name: String{ return self.rawValue}
    }
    
    func cache(forKey key: String) -> NSCoding? {
        return cache?.object(forKey: key)
    }
    
    func cache(_ object: NSCoding?, forKey key: String){
        cache?.setObject(object, forKey: key)
    }
    
    //硬盘 获取
    fileprivate func cache(forKey key: Label) -> NSCoding? {
        return cache?.object(forKey: key.name)
    }
    
    //硬盘 保存
    fileprivate func cache(_ object: NSCoding?, forKey key: Label){
        cache?.setObject(object, forKey: key.name)
    }
    
    //缓存 获取
    fileprivate func memoryCache(forKey key: Label) -> Any? {
        return cache?.memoryCache.object(forKey: key.name)
    }
    
    //缓存 保存
    fileprivate func memoryCache(_ object: NSCoding?, forKey key: Label){
        cache?.memoryCache.setObject(object, forKey: key.name)
    }
    
}

//保存 searchArr
extension FHYYCache {
    // 硬盘数组
    var searchHistories: [String] {
        set{
            cache(newValue as NSCoding, forKey: .searchHistory)
        }
        get{
            return cache(forKey: .searchHistory) as? [String] ?? [String]()
        }
    }
    // 添加硬盘数组
    func searchHistories(append str: String) {
        if str.isEmpty { return }
        if searchHistories.contains(str) { return }
        searchHistories += [str]
    }
    // 删除单个硬盘中的数组
    func searchHistories(remove str: String) {
        if str.isEmpty { return }
        searchHistories = searchHistories.filter({ (item) -> Bool in
            return item != str
        })
    }
    // 删除硬盘中的全部数组
    func searchHistoriesRemoveAll() {
        searchHistories.removeAll()
    }

}

// 保存用户名称 -- 用户缓存的
extension FHYYCache {
    
    var userName:String {
        set{
            if newValue != userName {
                memoryCache(newValue as NSCoding, forKey: .userName)
            }
        }
        get{
            return memoryCache(forKey: .userName) as? String ?? NullString
        }
    }

    
}


