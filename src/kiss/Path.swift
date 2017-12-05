//
//  Path.swift
//  kiss
//
//  Created by Stefan Keller on 02.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

// to draw something you'll have to have a notion of what to draw and a stylus
protocol Drawable {
    func draw(into context: CGContext)
}

protocol Stylus : Drawable {
    var lineWidth: CGFloat {get}
    var lineColor: CGColor? {get}
    var linePattern: [CGFloat]? {get}
    var fillColor: CGColor? {get}
    
    func draw(into context: CGContext)
}

struct DarkStylus : Stylus {
    var lineWidth: CGFloat = 2.0
    var lineColor: CGColor? = CGColor(gray: 0.1, alpha: 1.0)
    var linePattern: [CGFloat]? = nil
    var fillColor: CGColor? = nil
    
    func draw(into context: CGContext) {
        context.setStrokeColor(lineColor!)
        context.setLineWidth(lineWidth)
        context.strokePath()
    }
}

struct DottedLightStylus : Stylus {
    var lineWidth: CGFloat = 1.0
    var lineColor: CGColor? = CGColor(gray: 0.7, alpha: 1.0)
    var linePattern: [CGFloat]? = [ 2.0, 2.0 ]
    var fillColor: CGColor? = nil
    
    func draw(into context: CGContext) {
        context.setLineDash(phase: 0.0, lengths: linePattern!)
        context.setStrokeColor(lineColor!)
        context.setLineWidth(lineWidth)
        context.strokePath()
    }
}

//protocol Path : Drawable {
//    var elements: [Stride] {get}
//    var start: Point {get}
//    var end: Point {get}
//    var length: CGFloat {get}
//
//    var stylus: Stylus {get}
//    func draw(into context: CGContext)
//}

struct Path: Plottable, Drawable {
    let elements: [Stride]
    let start: Point
    let end: Point

    var stylus: Stylus

    let length: CGFloat
    
//    let lineWidth: CGFloat
//    let lineColor: CGColor?
//    let fillColor: CGColor?

    init(by stride: Stride, stylus: Stylus) {
        self.init(elements: [stride], start: stride.start, end: stride.end, stylus: stylus,
                  length: stride.length)
    }
    
    func line(to: Point) -> Path {
        return add(Line(start: self.end, end: to))
    }
    
    func quadCurve(to: Point, control: Point) -> Path {
        return add(QuadCurve(start: self.end, end: to, control: control))
    }
    
    func cubicCurve(to: Point, control1: Point, control2: Point) -> Path {
        return add(CubicCurve(start: self.end, end: to, control1: control1, control2: control2))
    }

    func plot(into context: CGContext) {
        context.move(to: elements[0].start.cgPoint())
        for e in elements {
            e.plot(into: context)
        }
    }
    
    func draw(into context: CGContext) {
        
        context.protect {
            context.move(to: elements[0].start.cgPoint())
            for e in elements {
                e.plotControlGraph(into: context)
            }
            DottedLightStylus().draw(into: context)
        }
        
        context.protect {
            self.plot(into: context)
            DarkStylus().draw(into: context)
        }
        
        //        context.protect {
        //            elements[0].start.drawBox(into: context)
        //            for e in elements {
        //                e.end.drawBox(into: context)
        //            }
        //        }
        
    }

    
    
    
    
    
    private func add(_ stride: Stride) -> Path {
        var strides = self.elements
        strides.append(stride)
        return Path(elements: strides,
                    start: self.start, end: stride.end, stylus: self.stylus,
                          length: self.length + stride.length)
    }

    private init(elements: [Stride], start: Point, end: Point, stylus: Stylus, length: CGFloat) {
        self.elements = elements
        self.start = start
        self.end = end
        self.length = length
        
        self.stylus = stylus
    }
    

}




//var mode: ShapeMode
//

//    init(json: JSON) {
//        // mode = .show
//        lineColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.222, 0.617, 0.976, 1.0])!
//
//        for key in json.keys {
//            switch key {
//            case "circle":
//                elements.append(Circle(json: json.jsonFor(key: key)))
//            case "bezier":
//                elements.append(Bezier(json: json.jsonFor(key: key)))
//                //                case "color":
//            //                    color = json.cgFloat(key: key)
//            case "lineWidth":
//                let lw = json.cgFloat(key: key)
//                if (lw != nil) { lineWidth = lw! }
//            default: ()
//            }
//        }
//    }

