import Foundation

struct OKMAModel {

    let indicatorType: OKIndicatorType
    let klineModels: [OKKLineModel]
    
    init(indicatorType: OKIndicatorType, klineModels: [OKKLineModel]) {
        self.indicatorType = indicatorType
        self.klineModels = klineModels
    }
    
    public func fetchDrawMAData(drawRange: NSRange?) -> [OKKLineModel] {
        //收盘价数组
        var datas = [OKKLineModel]()
        
        guard klineModels.count > 0 else {
            return datas
        }
        
        for (index, model) in klineModels.enumerated() {
            //计算收盘价总和   把模型中的所有收盘价加起来
            model.sumClose = model.close + (index > 0 ? klineModels[index - 1].sumClose! : 0)
            
            switch indicatorType {
            case .MA(let days):
                var values = [Double?]()
                for day in days {
                    //方法在下面
                    values.append(handleMA(day: day, model: model, index: index, models: klineModels))
                }
                //收盘价数组
                model.MAs = values
            default:
                break
            }

            datas.append(model)
        }
        
        if let range = drawRange {
            return Array(datas[range.location..<range.location+range.length])
        } else {
            return datas
        }
    }
    
    //在上面调用
    private func handleMA(day: Int, model: OKKLineModel, index: Int, models: [OKKLineModel]) -> Double? {
        if day <= 0 || index < (day - 1) {
            return nil
        }
        else if index == (day - 1) {
            return model.sumClose! / Double(day)
        }
        else {
            return (model.sumClose! - models[index - day].sumClose!) / Double(day)
        }
    }
}
