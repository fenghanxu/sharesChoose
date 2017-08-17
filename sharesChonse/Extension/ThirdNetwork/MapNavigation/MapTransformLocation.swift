//
//  MapTransformLocation.swift
//  Logistics
//
//  Created by 冯汉栩 on 2017/5/23.
//  Copyright © 2017年 ios.b7logistics.com. All rights reserved.
//

/*
 经纬度之间的互相转换，感觉不是很准。
 */

import UIKit

class MapTransformLocation: NSObject {
    
    fileprivate let jzEE:Double = 0.00669342162296594323
    fileprivate let jzA:Double = 6378245.0
    fileprivate let RANGE_LAT_MIN:Double = 0.8293
    fileprivate let RANGE_LAT_MAX:Double = 55.8271
    fileprivate let RANGE_LON_MIN:Double = 72.004
    fileprivate let RANGE_LON_MAX:Double = 137.8347
    
    fileprivate let pi:Double = 3.14159265358979324
    
    func LAT_OFFSET_0(x:Double, y:Double) ->(Double){
        let a:Double = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x))
        return a
    }
    
    func LAT_OFFSET_1(x:Double) ->(Double){
        let b:Double = (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0
        return b
    }
    
    func LAT_OFFSET_2(y:Double) ->(Double){
        let c:Double = (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0
        return c
    }
    
    func LAT_OFFSET_3(y:Double) ->(Double){
        let d:Double = (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0
        return d
    }
    
    /***********************************************/
    func LON_OFFSET_0(x:Double, y:Double) ->(Double){
        let a:Double = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x))
        return a
    }
    
    func LON_OFFSET_1(x:Double) ->(Double){
        let b:Double = (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0
        return b
    }
    
    func LON_OFFSET_2(x:Double) ->(Double){
        let c:Double = (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0
        return c
    }
    
    func LON_OFFSET_3(x:Double) ->(Double){
        let d:Double = (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0
        return d
    }
    
    /***********************************************/
    func transformLat(x:Double ,bdLon y:Double) ->(Double){
        var ret:Double = LAT_OFFSET_0(x: x, y: y)
        ret += LAT_OFFSET_1(x: x)
        ret += LAT_OFFSET_2(y: y)
        ret += LAT_OFFSET_3(y: y)
        return ret
    }
    
    func transformLon(x:Double ,bdLon y:Double) ->(Double){
        var ret:Double = LON_OFFSET_0(x: x, y: y)
        ret += LON_OFFSET_1(x: x)
        ret += LON_OFFSET_2(x: x)
        ret += LON_OFFSET_3(x: x)
        return ret
    }
    
    func outOfChina(lat:Double ,badLon lon:Double) ->(Bool){
        if lon < RANGE_LON_MIN || lon > RANGE_LON_MAX {
            return true
        }
        if lat < RANGE_LAT_MIN || lat > RANGE_LAT_MAX {
            return true
        }
        return false
    }
    
    /***********************************************/
    func gcj02Encrypt(ggLat:Double ,bdLon ggLon:Double) ->(CLLocationCoordinate2D){
        var resPoint:CLLocationCoordinate2D = CLLocationCoordinate2D()
        var mgLat:Double = 0
        var mgLon:Double = 0
        if outOfChina(lat: ggLat, badLon: ggLon) {
            resPoint.latitude = ggLat
            resPoint.longitude = ggLon
            return resPoint
        }
        var dLat:Double = transformLat(x: ggLon - 105, bdLon: ggLat - 35)
        var dLon:Double = transformLon(x: ggLon - 105, bdLon: ggLat - 35)
        let radLat:Double = ggLat / 180.0 * pi
        var magic:Double = sin(radLat)
        magic = 1 - jzEE * magic * magic
        let sqrtMagic:Double = sqrt(magic)
        dLat = (dLat * 180.0) / ((jzA * (1 - jzEE)) / (magic * sqrtMagic) * pi)
        dLon = (dLon * 180.0) / (jzA / sqrtMagic * cos(radLat) * pi)
        mgLat = ggLat + dLat
        mgLon = ggLon + dLon
        resPoint.latitude = mgLat
        resPoint.longitude = mgLon
        return resPoint
    }
    
    func gcj02Decrypt(gjLat:Double ,gjLons gjLon:Double) ->(CLLocationCoordinate2D){
        var gPt:CLLocationCoordinate2D = CLLocationCoordinate2D()
        gPt = gcj02Encrypt(ggLat: gjLat, bdLon: gjLon)
        let dLon:Double = gPt.longitude - gjLon
        let dLat:Double = gPt.latitude - gjLat
        var pt:CLLocationCoordinate2D = CLLocationCoordinate2D()
        pt.latitude = gjLat - dLat
        pt.longitude = gjLon - dLon
        return pt
    }
    
    func bd09Decrypt(bdLat:Double ,bdLons bdLon:Double) ->(CLLocationCoordinate2D){
        var gcjPt:CLLocationCoordinate2D = CLLocationCoordinate2D()
        let x:Double = bdLon - 0.0065
        let y:Double = bdLat - 0.006
        let z:Double = sqrt(x * x + y * y) - 0.00002 * sin(y * pi)
        let theta:Double = atan2(y, x) - 0.000003 * cos(x * pi)
        gcjPt.longitude = z * cos(theta)
        gcjPt.latitude = z * sin(theta)
        return gcjPt
    }
    
    func bd09Encrypt(ggLat:Double ,bdLons ggLon:Double) ->(CLLocationCoordinate2D){
        var bdPt:CLLocationCoordinate2D = CLLocationCoordinate2D()
        let x:Double = ggLon
        let y:Double = ggLat
        let z:Double = sqrt(x * x + y * y) + 0.00002 * sin(y * pi)
        let theta:Double = atan2(y, x) + 0.000003 * cos(x * pi)
        bdPt.longitude = z * cos(theta) + 0.0065
        bdPt.latitude = z * sin(theta) + 0.006
        return bdPt
    }
    
}

extension MapTransformLocation{
    
    /**
     *  @brief  世界标准地理坐标(WGS-84) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
     *
     *  ####只在中国大陆的范围的坐标有效，以外直接返回世界标准坐标
     *
     *  @param  location    世界标准地理坐标(WGS-84)
     *
     *  @return 中国国测局地理坐标（GCJ-02）<火星坐标>
     */
    func wgs84ToGcj02(location:CLLocationCoordinate2D) ->(CLLocationCoordinate2D){
        return gcj02Encrypt(ggLat: location.latitude, bdLon: location.longitude)
    }
    
    
    /**
     *  @brief  中国国测局地理坐标（GCJ-02） 转换成 世界标准地理坐标（WGS-84）
     *
     *  ####此接口有1－2米左右的误差，需要精确定位情景慎用
     *
     *  @param  location    中国国测局地理坐标（GCJ-02）
     *
     *  @return 世界标准地理坐标（WGS-84）
     */
    func gcj02ToWgs84(location:CLLocationCoordinate2D) ->(CLLocationCoordinate2D){
        return gcj02Decrypt(gjLat: location.latitude, gjLons: location.longitude)
    }
    
    /**
     *  @brief  世界标准地理坐标(WGS-84) 转换成 百度地理坐标（BD-09)
     *
     *  @param  location    世界标准地理坐标(WGS-84)
     *
     *  @return 百度地理坐标（BD-09)
     */
    func wgs84ToBd09(location:CLLocationCoordinate2D) ->(CLLocationCoordinate2D){
        var gcj02Pt:CLLocationCoordinate2D = CLLocationCoordinate2D()
        gcj02Pt = gcj02Encrypt(ggLat: location.latitude, bdLon: location.longitude)
        return bd09Encrypt(ggLat: gcj02Pt.latitude, bdLons: gcj02Pt.longitude)
    }
    
    /**
     *  @brief  中国国测局地理坐标（GCJ-02）<火星坐标> 转换成 百度地理坐标（BD-09)
     *
     *  @param  location    中国国测局地理坐标（GCJ-02）<火星坐标>
     *
     *  @return 百度地理坐标（BD-09)
     */
    func gcj02ToBd09(location:CLLocationCoordinate2D) ->(CLLocationCoordinate2D){
        return bd09Encrypt(ggLat: location.latitude, bdLons: location.longitude)
    }
    
    /**
     *  @brief  百度地理坐标（BD-09) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
     *
     *  @param  location    百度地理坐标（BD-09)
     *
     *  @return 中国国测局地理坐标（GCJ-02）<火星坐标>
     */
    func bd09ToGcj02(location:CLLocationCoordinate2D) ->(CLLocationCoordinate2D){
        return bd09Decrypt(bdLat: location.latitude, bdLons: location.longitude)
    }
    
    /**
     *  @brief  百度地理坐标（BD-09) 转换成 世界标准地理坐标（WGS-84）
     *
     *  ####此接口有1－2米左右的误差，需要精确定位情景慎用
     *
     *  @param  location    百度地理坐标（BD-09)
     *
     *  @return 世界标准地理坐标（WGS-84）
     */
    func bd09ToWgs84(location:CLLocationCoordinate2D) ->(CLLocationCoordinate2D){
        var gcj02:CLLocationCoordinate2D = CLLocationCoordinate2D()
        gcj02 = bd09ToGcj02(location: location)
        return gcj02Decrypt(gjLat: gcj02.latitude, gjLons: gcj02.longitude)
    }
    
}


