/*
 KDJ的计算公式 (一般是9,3,3)
 9日RSV = (C - L9) / (H9 - L9) * 100
 C  = 第九日的收盘价
 L9 = 九日内的最低价
 H9 = 九日内的最高价
 
 K值 = 2/3 * 前一天的K值 + 1/3*当日的RSV
 D值 = 2/3 * 前一天的D值 + 1/3*当日的K值
 (若无前一日的K值和D值，则可以分别用50代替)
 J值 = 3D - 2K
*/

import Foundation

struct OKKDJModel {
    
    let klineModels: [OKKLineModel]
    
    init(klineModels: [OKKLineModel]) {
        self.klineModels = klineModels
    }
    
    public func fetchDrawKDJData(drawRange: NSRange? = nil) -> [OKKLineModel] {
        var datas = [OKKLineModel]()
        
        guard klineModels.count > 0 else {
            return datas
        }
        
        for (index, model) in klineModels.enumerated() {
            let previousModel: OKKLineModel? = index > 0 ? klineModels[index - 1] : nil
            // 九个交易日内最低价
            model.minPriceOfNineClock = handleMinPriceOfNineClock(index: index, models: klineModels)
            // 九个交易日最高价
            model.maxPriceOfNineClock = handleMaxPriceOfNineClock(index: index, models: klineModels)
            // RSV(9) =（今日收盘价－9日内最低价）/（9日内最高价－9日内最低价）* 100
            model.RSV9 = handleRSV9(model: model)
            // K(3) =（当日RSV值+2*前一日K值）/ 3
            model.KDJ_K = handleKDJ_K(model: model, previousModel: previousModel)
            // D(3) =（当日K值 + 2*前一日D值）/ 3
            model.KDJ_D = handleKDJ_D(model: model, previousModel: previousModel)
            // J = 3K － 2D
            model.KDJ_J = handleKDJ_J(model: model)
            datas.append(model)
        }
        
        if let range = drawRange {
            return Array(datas[range.location..<range.location+range.length])
        } else {
            return datas
        }
    }
    
    // 九个交易日内最低价
    private func handleMinPriceOfNineClock(index: Int, models: [OKKLineModel]) -> Double {
        var minValue = models[index].low
        let startIndex = index < 9 ? 0 : (index - (9 - 1))
        
        for i in startIndex..<index {
            if models[i].low < minValue {
                minValue = models[i].low
            }
        }
        return minValue
    }
    
    // 九个交易日最高价
    private func handleMaxPriceOfNineClock(index: Int, models: [OKKLineModel]) -> Double {
        var maxValue = models[index].high
        let startIndex = index < 9 ? 0 : (index - (9 - 1))
        
        for i in startIndex..<index {
            if models[i].high > maxValue {
                maxValue = models[i].high
            }
        }
        return maxValue
    }
    
    // RSV(9) =（今日收盘价－9日内最低价）/（9日内最高价－9日内最低价）* 100
    private func handleRSV9(model: OKKLineModel) -> Double {
        
        guard let minPrice = model.minPriceOfNineClock,
            let maxPrice = model.maxPriceOfNineClock else {
                return 100.0
        }
        
        if minPrice == maxPrice {
            return 100.0
        } else {
            return (model.close - minPrice) / (maxPrice - minPrice) * 100
        }
    }
    
    // K(3) =（当日RSV值+2*前一日K值）/ 3
    private func handleKDJ_K(model: OKKLineModel, previousModel: OKKLineModel?) -> Double {
        
        if previousModel == nil { // 第一个数据
            return (model.RSV9! + 2 * 50) / 3
        } else {
            return (model.RSV9! + 2 * previousModel!.KDJ_K!) / 3
        }
    }
    
    // D(3) =（当日K值 + 2*前一日D值）/ 3
    private func handleKDJ_D(model: OKKLineModel, previousModel: OKKLineModel?) -> Double {
        if previousModel == nil { // 第一个数据
            return (model.KDJ_K! + 2 * 50) / 3
        } else {
            return (model.KDJ_K! + 2 * previousModel!.KDJ_D!) / 3
        }
    }
    
    
    private func handleKDJ_J(model: OKKLineModel) -> Double {
        
        let result = model.KDJ_K! * 3 - model.KDJ_D! * 2
        
        if result > 100 {
            return 100
        }else if result < 0 {
            return 0
        }else if result < 100 && result > 0{
            //这里很奇怪，绿色的公式是网上查询的计算公式，但是这样写显示出来J线是反过来的，要按照下面写才显示正确。
            //            return model.KDJ_D! * 3 - model.KDJ_K! * 2  //网上 J = 3D - 2K
            return result //     J =  3K - 2D
        }
        return 0
        
    }
    
}
