//#if os(iOS) || os(tvOS)

    import UIKit
    public typealias OKFont = UIFont
    public typealias OKColor = UIColor
    // 边距
    public typealias OKEdgeInsets = UIEdgeInsets
    //创建图形上下文(使用这个属性通常都会接着在下面绘图)
    func OKGraphicsGetCurrentContext() -> CGContext? {
        return UIGraphicsGetCurrentContext()
    }

extension OKFont {
    
    public class func systemFont(size: CGFloat) -> OKFont {
        return systemFont(ofSize: size)
    }
    
    public class func boldSystemFont(size: CGFloat) -> OKFont {
        return boldSystemFont(ofSize: size)
    }
    
}

extension OKColor {
    
    //MARK: - Hex
    
    public convenience init(hexRGB: Int, alpha: CGFloat = 1.0) {
        
        self.init(red:CGFloat((hexRGB >> 16) & 0xff) / 255.0,
                  green:CGFloat((hexRGB >> 8) & 0xff) / 255.0,
                  blue:CGFloat(hexRGB & 0xff) / 255.0,
                  alpha: alpha)
    }
    
    public class func randomColor() -> OKColor {
        
        return OKColor(red: CGFloat(arc4random_uniform(255)) / 255.0,
                       green: CGFloat(arc4random_uniform(255)) / 255.0,
                       blue: CGFloat(arc4random_uniform(255)) / 255.0,
                       alpha: 1.0)
        
    }
}


//#if os(iOS) || os(tvOS)

    class OKView: UIView {
        
        public var okBackgroundColor: OKColor? {
            didSet {
                backgroundColor = okBackgroundColor
            }
        }
        
        public func okSetNeedsDisplay() {
            //通过这个方法会调用drawRect,获取图片上下文进行绘图
            setNeedsDisplay()
        }
        
        public func okSetNeedsDisplay(_ rect: CGRect) {
            //通过这个方法会调用drawRect,获取图片上下文进行绘图
            setNeedsDisplay(rect)
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        override func draw(_ rect: CGRect) {
            super.draw(rect)
        }
    }

    class OKScrollView: UIScrollView {

    }
    
    class OKButton: UIButton {
        
    }
    

public func OKPrint(_ object: @autoclosure() -> Any?,
                    _ file: String = #file,
                    _ function: String = #function,
                    _ line: Int = #line) {
    #if DEBUG
        guard let value = object() else {
            return
        }
        var stringRepresentation: String?
        
        if let value = value as? CustomDebugStringConvertible {
            stringRepresentation = value.debugDescription
        }
        else if let value = value as? CustomStringConvertible {
            stringRepresentation = value.description
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss:SSS"
        let timestamp = formatter.string(from: Date())
        let queue = Thread.isMainThread ? "UI" : "BG"
        let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file"
        
        if let string = stringRepresentation {
            print("✅ \(timestamp) {\(queue)} \(fileURL) > \(function)[\(line)]: \(string)")
        } else {
            print("✅ \(timestamp) {\(queue)} \(fileURL) > \(function)[\(line)]: \(value)")
        }
    #endif
}

protocol OKDescriptable {
    func propertyDescription() -> String
}

extension OKDescriptable {
    func propertyDescription() -> String {
        let strings = Mirror(reflecting: self).children.flatMap { "\($0.label!): \($0.value)" }
        var string = ""
        for str in strings {
            string += str + "\n"
        }
        return string
    }
}


