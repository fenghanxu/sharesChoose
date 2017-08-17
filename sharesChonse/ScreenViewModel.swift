//
//  ScreenViewModel.swift
//  Demol
//
//  Created by 冯汉栩 on 2017/8/3.
//  Copyright © 2017年 hanxuFeng. All rights reserved.
//

import UIKit

import Alamofire

protocol ScreenViewModelDelegate:NSObjectProtocol {
    // 获取全部股票号码
    func screenViewModel(base:ScreenViewModel ,getAllSharesData soure:Any?)
    // 刷新股票总是UI
    func screenViewModel(base:ScreenViewModel ,updateAllSharesData archivingList:[String], sharesIndex:Int)
    // 刷新股票筛选进度
    func screenViewModel(base:ScreenViewModel ,updateScreenSpeedOfProgress sharesIndex:Int)
    // 刷新金叉数组tableView 和 实时显示金叉个数
    func screenViewModel(base:ScreenViewModel ,updateGoldenCross goldenCross:[String])

}

class ScreenViewModel: NSObject,NSCoding {
    
    //用于寻找金叉
    enum Macd {
        case TRUE
        case FALSE
        case NUKNOW
    }
    
    //全部股票是否获取成功
    enum Message {
        case Success
        case Fail
        case Unkonw//没有获取
    }
    
    let  asd = ["603817","603738","603698","603678","603663","603658","603508","603030","601989","601966","601890","601699","601677","601500","601228","600990","600986","600985","600976","600855","600825","600780","600775","600765","600749","600677","600576","600558","600512","600501","600495","600482","600435","600399","600372","600363","600233","600178","600161","600151","600123","600118","600075","600071","600038","300648","300645","300611","300581","300570","300558","300546","300543","300510","300505","300456","300427","300237","300227","300221","300192","300159","300149","300108","300090","300008","002855","002849","002788","002774","002700","002678","002663","002651","002639","002625","002615","002592","002578","002414","002366","002349","002222","002198","002190","002158","002151","002097","002046","002023","002017","002015","002013","000967","000908","000899","000811","000768","000738","000729","000710"]
    
    let  asds = ["002064"]
    
    //macd金叉数组
    var macdGoldenCross = [String]()
    
    //kdj金叉数组
    var kdjGoldenCross = [String]()
    
    //kdj和macd金叉数组
    var kdjAndMacdGoldenCross = [String](){
        didSet{
            if kdjAndMacdGoldenCross.isEmpty {
                return
            }
            delegate?.screenViewModel(base: self, updateGoldenCross: kdjAndMacdGoldenCross)
        }
    }
    
    
    //记录筛选中停止
    var screenStop:Bool = true{
        didSet{
            if screenStop != oldValue {
                if screenStop == true && !allSharesData.isEmpty {
                    getFetchData(shares: allSharesData[sharesIndex])
                }else{
                    if macdGoldenCross.isEmpty {
                        return
                    }
                    delegate?.screenViewModel(base: self, updateGoldenCross: kdjAndMacdGoldenCross)
                }
            }
        }
    }
    
    var sharesMessage = Message.Unkonw
    // 用于记录MACD金叉
    fileprivate var DeaBig = Macd.TRUE
    fileprivate var DifBig = Macd.FALSE
    fileprivate var CenterTag = Macd.NUKNOW
    
    fileprivate var kdj_D = Macd.TRUE
    fileprivate var kdj_K = Macd.FALSE
    fileprivate var kdj_center = Macd.NUKNOW
    
    weak var delegate:ScreenViewModelDelegate?
    
    /// 开始draw的下标
    fileprivate var drawStartIndex: Int?
    fileprivate var lastOffsetIndex: Int?
    //设置样式
    fileprivate var configuration = OKConfiguration()
    // 归档解档地址
    let userAccountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! + "/userAccount.plist"
    
    //所有股票号码
    var allSharesData = [String](){
        didSet{
            if allSharesData.count != oldValue.count {
                if screenStop == true {
                    getFetchData(shares: allSharesData[sharesIndex])
                }
                print("股票数量 = \(allSharesData.count)")
            }
        }
    }
    
    //记录搜索股票索引
    var sharesIndex:Int = 0{
        didSet{
            if sharesIndex != oldValue {
                drawRange = NSMakeRange(0, 0)
                accessoryDrawKLineModels = [OKKLineModel]()
                if !klineModels.isEmpty {
                    klineModels = [OKKLineModel]()
                }
                //复位
                DeaBig = Macd.TRUE
                DifBig = Macd.FALSE
                CenterTag = Macd.NUKNOW
                
                kdj_K = Macd.TRUE
                kdj_D = Macd.FALSE
                kdj_center = Macd.NUKNOW
                
                print("股票序号 = \(sharesIndex)")
                print("股票号码 = \(allSharesData[sharesIndex])")
                if screenStop == true {
                    getFetchData(shares: allSharesData[sharesIndex])
                }
                delegate?.screenViewModel(base: self, updateScreenSpeedOfProgress: sharesIndex)
            }
        }
    }
    
    //总的数据
    fileprivate var klineModels = [OKKLineModel](){
        didSet{
            if klineModels.isEmpty {
                return
            }

            //总的返回为0就不筛选，大于3就3小于3  就count,之前屏幕是写106是因为，屏幕能最多显示106格，但是我在筛选的时候最需要用到当前之前的3天的数据，所以就写3.加快便利速度。
            
            if klineModels.count >= 3 {
                calculationStartPoint(tag: true, drawingCount: 3)
            }else if klineModels.count < 3 {
                calculationStartPoint(tag: true, drawingCount: klineModels.count)
            }
            
        }
    }
    
    //记录起点，绘制个数
    fileprivate var drawRange: NSRange = NSRange(){
        didSet{
            if drawRange.length != 0 {
                fetchAccessoryDrawKLineModels()
                guard let accessoryModel = accessoryDrawKLineModels else {
                    return
                }
                findGoldenCross(accessoryModel: accessoryModel)
            }
        }
    }
    
    // 指标绘制K线模型数组
    fileprivate var accessoryDrawKLineModels: [OKKLineModel]?
//    {
//        didSet{
//            if (accessoryDrawKLineModels?.isEmpty)! {
//                return
//            }
//            
//            print("DIF,DEA数组 = \(String(describing: accessoryDrawKLineModels?.count))")
//            
//            guard let accessoryModel = accessoryDrawKLineModels else {
//                return
//            }
//            
//            for (index, model) in (accessoryModel.enumerated())  {
//                if index >= accessoryModel.count - 2 {
////                    print("日期 = \(model.date)")
////                    print("DIF = \(String(describing: model.DIF))")
////                    print("DEA = \(String(describing: model.DEA))")
//                    
//                    print("日期 = \(model.date)")
//                    print("KDJ_D = \(String(describing: model.KDJ_D))")
//                    print("KDJ_K = \(String(describing: model.KDJ_K))")
//                    
//                   var macdName = NullString
//                   macdName = findMACD(DEA: Double(model.DEA ?? 0.0) , DIF: Double(model.DIF ?? 0.0))
//                   if macdName == "金叉" {
//                      macdGoldenCross.append(model.code)
//                   }
//                    
//                    var kdjName = NullString
//                    kdjName = findKDJ(KDJ_D: Double(model.KDJ_D ?? 0.0), KDJ_K: Double(model.KDJ_K ?? 0.0))
//                    if kdjName == "金叉" {
//                      kdjGoldenCross.append(model.code)
//                   }
//                    
//                   if macdName == kdjName && kdjName == "金叉" {
//                      kdjAndMacdGoldenCross.append(model.code)
//                   }
//                    
//                    
//                }
//            }
//            
//            if sharesIndex < allSharesData.count - 1 {
//                print("\n")
//                sharesIndex += 1
//            }else{
//                for item in macdGoldenCross {
//                    print("金叉股票号码 = \(item)")
//                }
//            }
//            
//        }
//    }
    
    // 归档解档数据
    var archivingList:[String] = [String](){
        didSet{
            if archivingList.isEmpty {
                return
            }
            delegate?.screenViewModel(base: self, updateAllSharesData: archivingList, sharesIndex: sharesIndex)
        }
    }
    
    override init() {
        super.init()
    }
    
    // MARK:- 处理需要归档的字段
    func encode(with aCoder:NSCoder) {
        
        aCoder.encode(archivingList, forKey: "archivingList")
    }
    
    // MARK:- 处理需要解档的字段
    required init(coder aDecoder:NSCoder) {
        super.init()
        archivingList = aDecoder.decodeObject(forKey: "archivingList") as! [String]
    }
    
}

extension ScreenViewModel {
    
    func getFetchData(shares:String){
        let param = ["appid" : "ed547aae2d50406a6c71be2144b55cc4",
                     "code" : shares,
                     "index" : "false",
                     "k_type" : "day",
                     "fq_type" : "qfq",
                     "start_date" : "",
                     "end_date" : ""]
        
        let main_url = "http://api.shenjianshou.cn"
        
        Alamofire.request(main_url, method: .get, parameters: param).responseJSON { [weak self](returnResult) in
            
            guard let base = self else{ return }
            
            var model = [OKKLineModel]()
            
            switch returnResult.result {
            case .success(let value):
                if let dict = value as? [String: Any],let originalArray = dict["data"] as? [[String: Any]] {
                    
                    print("个股股票数组个数 = \(originalArray.count)")
                    
                    for data in originalArray {
                        let originaModel = OKKLineModel(close: data["close"] as! String, code: data["code"] as! String, date: data["date"] as! String, high: data["high"] as! String, low: data["low"] as! String, open: data["open"] as! String, volume: data["volume"] as! String)
                        model.append(originaModel)
                        
                    }
                }
                if model.count == 0{
                    if base.sharesIndex < base.allSharesData.count - 1 {
                        print("\n")
                        base.sharesIndex += 1
                    }else{
                        for item in base.macdGoldenCross {
                            print("金叉股票号码 = \(item)")
                        }
                    }
                    return
                }
                base.klineModels = model
                base.sharesMessage = .Success
            case .failure(let error):
                print(error)
                base.sharesMessage = .Fail
                if base.sharesIndex < base.allSharesData.count - 1 {
                    print("\n")
                    base.sharesIndex += 1
                }else{
                    for item in base.macdGoldenCross {
                        print("金叉股票号码 = \(item)")
                    }
                }
            }
        }
    }
    
    //获取3040个股票的号码
    func  getGrailData(){
        
        let main_url = "http://api.shenjianshou.cn/?appid=9755b8480944074c62d4344d40214fe2"
        
        Alamofire.request(main_url, method: .get, parameters: nil).responseJSON { [weak self](returnResult) in
            
            guard let base = self else { return }
            
            print("returnResult = \(returnResult)")
            
            var model = [String]()
            
            switch returnResult.result {
            case .success(let value):
                
                if let dict = value as? [String: Any],let originalArray = dict["data"] as? [[String: Any]] {
                    
                    print(originalArray.count)
                    
                    for data in originalArray {
                        model.append(data["code"] as! String)
                    }
                }
                //归档
                base.archivingList = model
                NSKeyedArchiver.archiveRootObject(base, toFile:base.userAccountPath)
            case .failure(let error):
                print(error)
                
                base.delegate?.screenViewModel(base: base, getAllSharesData: nil)
            }
            
            
        }
        
    }
    
    // 计算起点,绘制多小的K线  绘制的模型
    func calculationStartPoint(tag:Bool,drawingCount:Int){
        // 展示的个数
        // 绘制起始个数什么都没有
        if drawStartIndex == nil {
            //起始个数 = 模型中的个数 - 要绘制点的个数 - 1
            drawStartIndex = klineModels.count - drawingCount - 1
        }
        
        //如果记录的最后一个格数
        if lastOffsetIndex != nil {
            //把起始格数 = 起始格数 - 最后记录的格数
            drawStartIndex! -= lastOffsetIndex!
        }
        
        //如果起点大于0 起点的值不变，如果起点小于等于0  起点就等于0
        drawStartIndex! = drawStartIndex! > 0 ? drawStartIndex! : 0
        
        //起始格数 大于 模型中的个数 - 要绘制点的个数 - 1
        if drawStartIndex! > klineModels.count - drawingCount - 1 {
            //设置起始格数 等于 模型中的个数 - 要绘制点的个数 - 1
            drawStartIndex! = klineModels.count - drawingCount - 1
        }
        //清楚绘制范围的模型数据
//        drawKLineModels.removeAll()
        
        let loc = drawStartIndex! > 0 ? drawStartIndex! + 1 : 0
        
        //把要绘制的前存起来
        //获取模型范围的值  loc..<loc+drawCount  然后把它存到drawKLineModels中
        //        drawKLineModels = Array(klineModels[loc..<loc+drawingCount])
        print("loc = \(loc)")
        print("drawingCount = \(drawingCount)")
        
        //传递起点，绘制个数
        drawRange = NSMakeRange(loc, drawingCount)
        
        if tag {
            drawStartIndex = nil
            lastOffsetIndex = nil
        }
        
    }
    
    func fetchAccessoryDrawKLineModels() {
        
        guard klineModels.count > 0 else {
            accessoryDrawKLineModels = nil
            return
        }
        
        
        
        let kdjModel = OKKDJModel(klineModels: klineModels)
        accessoryDrawKLineModels = kdjModel.fetchDrawKDJData(drawRange: drawRange)
        
        let macdModel = OKMACDModel(klineModels: klineModels)
        accessoryDrawKLineModels = macdModel.fetchDrawMACDData(drawRange: drawRange)
        
//        switch configuration.accessory.indicatorType {
//        case .MACD:
//            let macdModel = OKMACDModel(klineModels: klineModels)
//            accessoryDrawKLineModels = macdModel.fetchDrawMACDData(drawRange: drawRange)
//            
//        case .KDJ:
//            let kdjModel = OKKDJModel(klineModels: klineModels)
//            accessoryDrawKLineModels = kdjModel.fetchDrawKDJData(drawRange: drawRange)
//        default:
//            break
//        }
        
    }
    
    //计算Macd金叉死叉
    func findMACD(DEA:Double,DIF:Double) ->(String){
        var result:String = NullString
        
        if DEA >= DIF && DEA != 0.0 && DIF != 0.0 {
            
            if CenterTag == .TRUE {   result = "Nil" }
            
            if CenterTag == .FALSE {
                CenterTag = DeaBig
                result = "死叉"
            }
            
            if CenterTag == .NUKNOW {
                CenterTag = .TRUE
                result = "Nil"
            }
            
        }
        
        if DIF >= DEA && DEA != 0.0 && DIF != 0.0 {
            if CenterTag == .FALSE {   result = "Nil" }
            
            if CenterTag == .TRUE {
                CenterTag = DifBig
                result = "金叉"
            }
            
            if CenterTag == .NUKNOW {
                CenterTag = .FALSE
                result = "Nil"
            }
        }
        return result
    }
    
    //计算Kdj金叉死叉
    func findKDJ(KDJ_D:Double,KDJ_K:Double) ->(String){
        var result:String = NullString
        
        if KDJ_D >= KDJ_K && KDJ_D != 0.0 && KDJ_K != 0.0 {
            if kdj_center == .TRUE {
                result = "Nil"
            }
            if kdj_center == .FALSE {
                kdj_center = kdj_D
                result = "死叉"
            }
            
            if kdj_center == .NUKNOW {
                kdj_center = .TRUE
                result = "Nil"
            }
        }
        
        if KDJ_D <= KDJ_K && KDJ_D != 0.0 && KDJ_K != 0.0 {
            if kdj_center == .FALSE {
                result = "Nil"
            }
            if kdj_center == .TRUE {
                kdj_center = kdj_K
                result = "金叉"
            }
            
            if kdj_center == .NUKNOW {
                kdj_center = .FALSE
                result = "Nil"
            }
        }
        return result
        
    }
    
    func findGoldenCross(accessoryModel:[OKKLineModel]){
        //accessoryDrawKLineModels
        if accessoryModel.isEmpty {
            return
        }
        
        print("DIF,DEA数组 = \(String(describing: accessoryModel.count))")
        
//        guard let accessoryModel = model else {
//            return
//        }
        
        for (index, model) in (accessoryModel.enumerated())  {
            if index >= accessoryModel.count - 2 {
                //                    print("日期 = \(model.date)")
                //                    print("DIF = \(String(describing: model.DIF))")
                //                    print("DEA = \(String(describing: model.DEA))")
                
                print("日期 = \(model.date)")
                print("KDJ_D = \(String(describing: model.KDJ_D))")
                print("KDJ_K = \(String(describing: model.KDJ_K))")
                
                var macdName = NullString
                macdName = findMACD(DEA: Double(model.DEA ?? 0.0) , DIF: Double(model.DIF ?? 0.0))
                if macdName == "金叉" {
                    macdGoldenCross.append(model.code)
                }
                
                var kdjName = NullString
                kdjName = findKDJ(KDJ_D: Double(model.KDJ_D ?? 0.0), KDJ_K: Double(model.KDJ_K ?? 0.0))
                if kdjName == "金叉" {
                    kdjGoldenCross.append(model.code)
                }
                
                if macdName == kdjName && kdjName == "金叉" {
                    kdjAndMacdGoldenCross.append(model.code)
                }
                
                
            }
        }
        
        if sharesIndex < allSharesData.count - 1 {
            print("\n")
            sharesIndex += 1
        }else{
            for item in kdjAndMacdGoldenCross {
                print("Macd+KDJ金叉股票号码 = \(item)")
            }
            if kdjAndMacdGoldenCross.isEmpty {
                return
            }
            delegate?.screenViewModel(base: self, updateGoldenCross: kdjAndMacdGoldenCross)
        }

    
    }
    
    

}

