import Foundation

/// k线类型
enum OKKLineDataType: Int {
    case BTC
    case LTC
    case ETH
    case other
}

class OKKLineModel: OKDescriptable {
    
    var klineDataType: OKKLineDataType
    // 日期
    var date: String = NullString
    // 开盘价
    var open: Double = 0.0
    // 收盘价
    var close: Double = 0.0
    // 最高价
    var high: Double = 0.0
    // 最低价
    var low: Double = 0.0
    // 成交量
    var volume: Double = 0.0
    // 股票号
    var code: String = NullString
    
    // MARK: 指标
    // 该model以及之前所有开盘价之和
    var sumOpen: Double?
    
    // 该model以及之前所有收盘价之和
    var sumClose: Double?
    
    // 该model以及之前所有最高价之和
    var sumHigh: Double?
    
    // 该model以及之前所有最低价之和
    var sumLow: Double?
    
    // 该model以及之前所有成交量之和
    var sumVolume: Double?
    
    // MARK: MA - MA(N) = (C1+C2+……CN) / N, C:收盘价
    var MAs: [Double?]?
    var MA_VOLUMEs: [Double?]?
    
    // MARK: EMA - EMA(N) = 2 / (N+1) * (C-昨日EMA) + 昨日EMA, C:收盘价
    var EMAs: [Double?]?
    var EMA_VOLUMEs: [Double?]?
    
    // MARK: MACD
    
    // DIF = EMA(12) - EMA(26)
    var DIF: Double?
    // DEA = （前一日DEA X 8/10 + 今日DIF X 2/10）
    var DEA: Double?
    // MACD(12,26,9) = (DIF - DEA) * 2
    var MACD: Double?
    
    // MARK: KDJ(9,3,3) 代表指标分析周期为9天，K值D值为3天
    // 九个交易日内最低价
    var minPriceOfNineClock: Double?
    // 九个交易日最高价
    var maxPriceOfNineClock: Double?
    // RSV(9) =（今日收盘价－9日内最低价）/（9日内最高价－9日内最低价）* 100
    var RSV9: Double?
    // K(3) =（当日RSV值+2*前一日K值）/ 3
    var KDJ_K: Double?
    // D(3) =（当日K值 + 2*前一日D值）/ 3
    var KDJ_D: Double?
    // J = 3K － 2D
    var KDJ_J: Double?
    
    // MARK: BOLL
    // 中轨线
    var BOLL_MB: Double?
    // 上轨线
    var BOLL_UP: Double?
    // 下轨线
    var BOLL_DN: Double?

    init(klineDataType: OKKLineDataType = .BTC,
         close: String,
         code: String,
         date: String,
         high: String,
         low: String,
         open: String,
         volume: String) {
        
        self.klineDataType = klineDataType        
        self.close = close.double!
        self.code = code
        self.date = date
        self.high = high.double!
        self.low = low.double!
        self.open = open.double!
        self.volume = volume.double!
        
    }
    

    
}
