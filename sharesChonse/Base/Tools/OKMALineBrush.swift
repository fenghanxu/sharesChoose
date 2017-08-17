#if os(iOS) || os(tvOS)
    import UIKit
#else
    import Cocoa
#endif
import CoreGraphics

enum OKBrushType {
    case MA(Int)
    case EMA(Int)
    case MA_VOLUME(Int)
    case EMA_VOLUME(Int)
}

class OKMALineBrush {
    
    public var calFormula: ((Int, OKKLineModel) -> CGPoint?)?
    public var brushType: OKBrushType
    private var configuration: OKConfiguration
    private var context: CGContext
    private var firstValueIndex: Int?
    
    //设置线条的基本信息
    init(brushType: OKBrushType, context: CGContext, configuration: OKConfiguration) {
        self.brushType = brushType
        self.context = context
        self.configuration = configuration
        //设置线的宽度
        context.setLineWidth(configuration.theme.indicatorLineWidth)
        //设置线条的终点样式
        context.setLineCap(.round)
        //设置线条的起点样式
        context.setLineJoin(.round)
        
        switch brushType {
        case .MA(let day):
            context.setStrokeColor(configuration.theme.MAColor(day: day).cgColor)
        case .EMA(let day):
            context.setStrokeColor(configuration.theme.EMAColor(day: day).cgColor)
        case .MA_VOLUME(let day):
            context.setStrokeColor(configuration.theme.MAColor(day: day).cgColor)
        case .EMA_VOLUME(let day):
            context.setStrokeColor(configuration.theme.EMAColor(day: day).cgColor)
        }
    }
    
    //绘制线条的方法
    public func draw(drawModels: [OKKLineModel]) {
        //拷贝数组中拿出来的值
        for (index, model) in drawModels.enumerated() {
            
            if let point = calFormula?(index, model) {
                
                if firstValueIndex == nil {
                    firstValueIndex = index
                }
                
                if firstValueIndex == index {
                    //添加线条路径(起点)
                    context.move(to: point)
                } else {
                    //添加线条路径(起点后的所有点)
                    context.addLine(to: point)
                }
            }
        }
        //渲染
        context.strokePath()
    }
}

