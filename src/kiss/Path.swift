//
//  Path.swift
//  kiss
//
//  Created by Stefan Keller on 02.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

protocol Path : Drawable {
    var elements: [Stride] {get}
    var start: Point {get}
    var end: Point {get}
    var length: CGFloat {get}
    
    var lineWidth: CGFloat {get}
    var lineColor: CGColor? {get}
    var fillColor: CGColor? {get}

    func draw(into context: CGContext)
}

extension Path {
    
    func draw(into context: CGContext) {
        
        context.protect {
            context.move(to: elements[0].start.cgPoint())
            for e in elements {
                e.drawControlGraph(into: context)
            }
            let pattern: [CGFloat] = [ 2.0, 2.0 ]
            context.setLineDash(phase: 0.0, lengths: pattern)

            context.setStrokeColor(CGColor(gray: 0.7, alpha: 1.0))
            context.setLineWidth(1.0)
            context.strokePath()
        }
   
        context.protect {
            context.move(to: elements[0].start.cgPoint())
            for e in elements {
                e.drawTo(into: context)
            }
            context.setStrokeColor(lineColor!)
            context.setLineWidth(lineWidth)
            context.strokePath()
        }
        
        context.protect {
            elements[0].start.drawBox(into: context)
            for e in elements {
                e.end.drawBox(into: context)
            }
        }
        
    }

}

struct SinglePath : Path {
    let elements: [Stride]
    let start: Point
    let end: Point
    let length: CGFloat
    
    let lineWidth: CGFloat
    let lineColor: CGColor?
    let fillColor: CGColor?

    init(by stride: Stride,
         lineWidth: CGFloat = 2.0,
         lineColor: CGColor? = CGColor(gray: 0.1, alpha: 1.0),
         fillColor: CGColor? = nil) {
        self.init(elements: [stride], start: stride.start, end: stride.end, length: stride.length,
                  lineWidth: lineWidth, lineColor: lineColor, fillColor: fillColor)
    }
    
    func line(to: Point) -> SinglePath {
        return add(Line(start: self.end, end: to))
    }
    
    func quadCurve(to: Point, control: Point) -> SinglePath {
        return add(QuadCurve(start: self.end, end: to, control: control))
    }
    
    func cubicCurve(to: Point, control1: Point, control2: Point) -> SinglePath {
        return add(CubicCurve(start: self.end, end: to, control1: control1, control2: control2))
    }

    private func add(_ stride: Stride) -> SinglePath {
        var strides = self.elements
        strides.append(stride)
        return SinglePath(elements: strides,
                          start: self.start, end: stride.end,
                          length: self.length + stride.length,
                          lineWidth: self.lineWidth, lineColor: self.lineColor, fillColor: self.fillColor)
    }

    private init(elements: [Stride], start: Point, end: Point, length: CGFloat,
                 lineWidth: CGFloat, lineColor: CGColor?, fillColor: CGColor?) {
        self.elements = elements
        self.start = start
        self.end = end
        self.length = length
        
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.fillColor = fillColor
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

