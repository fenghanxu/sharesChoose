//
//  MapNavigation.swift
//  Logistics
//
//  Created by iOS1002 on 2017/5/24.
//  Copyright © 2017年 ios.b7logistics.com. All rights reserved.
//


/*
使用方法的前提条件:
 1.在Info.plist里面配置同意打开高德百度地图
 2.导入百度SDK.下面用到GCJ-02坐标转BD-09的方法
 */

//#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
import UIKit

class MapNavigation: NSObject {

  //使用高德地图导航
  func poGaodeScanner(endLocation:String){
    let endLocationA = endLocation.components(separatedBy: ",")
    var endLocationB = CLLocationCoordinate2D()
    endLocationB.latitude = endLocationA[0].double ?? 0.0
    endLocationB.longitude = endLocationA[1].double ?? 0.0
    let projectName:String = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    let map5:String = "iosamap://navi?sourceApplication="+projectName+"&backScheme="+projectName+"&lat="+String(endLocationB.latitude)+"&lon="+String(endLocationB.longitude)+"&dev=0&style=2"
    print("map3 = \(map5)")
    //判断能否打开高德 -- 在info.plist中设置
    let scheme = NSURL(string: "iosamap://")
    //判断能够打开高德   true 可以  false 不行
    if UIApplication.shared.canOpenURL(scheme! as URL) {
      let myLocationSchemeURL = URL(string: map5)
      if #available(iOS 10.0, *) {
        print("10以上")
        UIApplication.shared.open(myLocationSchemeURL!, options: [:], completionHandler: { (_) in
          print("scheme调用结束")
        })
      }else {
        print("10以下")
      }
    }else{
      print("不能打开高德")
    }
  }

  //使用百度地图导航
/*
下面的方法是用于高德经纬度地区百度地图进行导航的，导航之前必须要进行金维度转换，BMKConvertBaiduCoorFrom下面会调用这个方法，但是问题是在上架的时候报了一个错，始终解决不了
       "_BMKConvertBaiduCoorFrom", referenced from:
     我怀疑是程序找不到这个方法引用的地方，但是demol运行时没有问题的。所以我把它注释掉。以后用到看能不能解决或者找其他方法代替
*/
    
    
//  func poBaiDuScanner(startLocation:CLLocationCoordinate2D,endLocation:String){
//    let start = CLLocationCoordinate2DMake(startLocation.latitude, startLocation.longitude)
//    var startDic:[String: String] = BMKConvertBaiduCoorFrom(start, BMK_COORDTYPE_COMMON) as! [String : String]
//    let yStartStr = startDic["x"]
//    let xStartStr = startDic["y"]
//    let xStartDate:NSData = NSData(base64Encoded: xStartStr!, options: NSData.Base64DecodingOptions(rawValue: UInt(0)))!
//    let yStartDate:NSData = NSData(base64Encoded: yStartStr!, options: NSData.Base64DecodingOptions(rawValue: UInt(0)))!
//    let xStartLat:NSString = NSString(data: xStartDate as Data, encoding: String.Encoding.utf8.rawValue)!
//    let yStartLng:NSString = NSString(data: yStartDate as Data, encoding: String.Encoding.utf8.rawValue)!
//    let startLoctionBString:String = (xStartLat as String) + "," + (yStartLng as String)
//
//    let endLocationA = endLocation.components(separatedBy: ",")
//    var endLocationB = CLLocationCoordinate2D()
//    endLocationB.latitude = endLocationA[0].double ?? 0.0
//    endLocationB.longitude = endLocationA[1].double ?? 0.0
//    let end = CLLocationCoordinate2DMake(endLocationB.latitude, endLocationB.longitude)
//    var endDic:[String: String] = BMKConvertBaiduCoorFrom(end, BMK_COORDTYPE_COMMON) as! [String : String]
//    let yEndStr = endDic["x"]
//    let xEndStr = endDic["y"]
//    let xEndDate:NSData = NSData(base64Encoded: xEndStr!, options: NSData.Base64DecodingOptions(rawValue: UInt(0)))!
//    let yEndDate:NSData = NSData(base64Encoded: yEndStr!, options: NSData.Base64DecodingOptions(rawValue: UInt(0)))!
//    let xEndLat:NSString = NSString(data: xEndDate as Data, encoding: String.Encoding.utf8.rawValue)!
//    let yEndLng:NSString = NSString(data: yEndDate as Data, encoding: String.Encoding.utf8.rawValue)!
//    let endLoctionBString:String = (xEndLat as String) + "," + (yEndLng as String)
//    let map5:String = "baidumap://map/direction?origin="+startLoctionBString+"&destination="+endLoctionBString+"&mode=driving&src=webapp.navi.yourCompanyName.yourAppName"
//    //判断能否打开高德
//    let scheme = NSURL(string: "baidumap://")
//    //判断能够打开高德   true 可以  false 不行
//    if UIApplication.shared.canOpenURL(scheme! as URL) {
//      let myLocationSchemeURL = URL(string: map5)
//      if #available(iOS 10.0, *) {
//        print("10以上")
//        UIApplication.shared.open(myLocationSchemeURL!, options: [:], completionHandler: { (_) in
//          print("scheme调用结束")
//        })
//      }else {
//        print("10以下")
//      }
//    }else{
//      print("不能打开高德")
//    }
//  }

}
