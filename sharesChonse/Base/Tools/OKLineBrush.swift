#if os(iOS) || os(tvOS)
    import UIKit
#else
    import Cocoa
#endif
import CoreGraphics

class OKLineBrush {
    
    public var calFormula: ((Int, OKKLineModel) -> CGPoint?)?
    public var indicatorType: OKIndicatorType
    private var configuration: OKConfiguration
    private var context: CGContext
    private var firstValueIndex: Int?
    
    
    
    //设置线的基本信息
    init(indicatorType: OKIndicatorType, context: CGContext, configuration: OKConfiguration) {
        self.indicatorType = indicatorType
        self.context = context
        self.configuration = configuration
        
        //设置线条宽度
        context.setLineWidth(configuration.theme.indicatorLineWidth)
        //设置线条结束断点样式(圆)
        context.setLineCap(.round)
        //设置线条转角样式(圆)
        context.setLineJoin(.round)
        //设置线条颜色
        switch indicatorType {
        case .DIF:
            context.setStrokeColor(configuration.theme.DIFColor.cgColor)
        case .DEA:
            context.setStrokeColor(configuration.theme.DEAColor.cgColor)
        case .KDJ_K:
            context.setStrokeColor(configuration.theme.KDJ_KColor.cgColor)
        case .KDJ_D:
            context.setStrokeColor(configuration.theme.KDJ_DColor.cgColor)
        case .KDJ_J:
            context.setStrokeColor(configuration.theme.KDJ_JColor.cgColor)
        case .BOLL_MB:
            context.setStrokeColor(configuration.theme.BOLL_MBColor.cgColor)
        case .BOLL_UP:
            context.setStrokeColor(configuration.theme.BOLL_UPColor.cgColor)
        case .BOLL_DN:
            context.setStrokeColor(configuration.theme.BOLL_DNColor.cgColor)
        default: break
        }
    }
    
    //绘制线的方法
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
