//
//  Shape.swift
//  kiss
//
//  Created by Stefan Keller on 25.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

protocol Shape : Drawable {
    //var mode: ShapeMode {get set}
    //var size: CGSize {get}
    //var matrix: CGAffineTransform { get }
    //var anchor: AnchorPoint { get }
    func draw(into context: CGContext)
}

//
//
////  Drawable     -> Stride          -> Path                   -> Shape
////
////  draw()          startPos           startPos                  size
////                  endPos             endPos                    anchorPoint
////                  length             length                    matrix (coordinate-System)
////                  size               size
////                                     color (stroke/fill)
////                                     strokethickness
////
////                  controlPoints
////
////
////
//
//// Constraints "has to be":       example:
//// exactely_at                    "draw point exactely at 1,2"
//// element of                     "point A is elemente of line B"
//

struct Scene : Shape {

    //    // abstraction for primitives and compounds (maybe a group of points, some lines, text etc.)
    //    func anchorPoint() -> [CGFloat]? // coords(n-dim)
    //    func content() -> [Form]
    //    func size() -> [CGFloat] //pos coords(n-dim) interpreted as dist from origin (0, ..., 0)
    //    func matrix() -> [CGFloat]?

    // Transformation-Matrix

    // translation
    // skew
    // scale
    // rotation
    // perspective projection

    //https://www.w3.org/TR/css-transforms-1/#decomposing-a-3d-matrix
    //Input:
    //matrix      ; a nxn matrix for a n-1 dim transformation
    //
    //Output:
    //translation ; a n-1 component vector
    //scale       ; a n-1 component vector
    //skew        ; skew factors XY,XZ,YZ,... represented as a n-1 component vector
    //perspective ; a n component vector
    //rotation    ; a n component vector (a quaternion if 3-dim space)

    var elements: [Drawable] = []

    func draw(into context: CGContext) {
        for f in elements {
            f.draw(into: context)
        }
    }
    
    init() {
        
    }

    init(by path: Path) {
        self.elements = [path]
    }
    
//    mutating func add(other: Drawable) {
//        elements.append(other)
//    }

    //strokeColor
    //lineWith


    //let lightBlue = CGColor(
    //    colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.222, 0.617, 0.976, 1.0])!
    //context.setStrokeColor(lightBlue)
    //context.setLineWidth(3)
    //context.strokePath()

    //        protectGState {
    //            context.addEllipse(in: rect)
    //            color.set()
    //
    //            if filled {
    //                context.fillPath()
    //            } else {
    //                context.strokePath()
    //            }
    //        }
    //
    ////        protectGState {
    ////            context.addEllipse(in: rect)
    ////            NSColor.black.set()
    ////            context.strokePath()
    ////        }


}

//class SceneBuilder {
//
//    let definition: JSON
//
//    init(by definition: JSON) {
//        self.definition = definition
//    }
//
//    func build() -> Scene {
//        var result: Scene = Scene()
//        for key in definition.keys {
//            let json = definition.jsonFor(key: key)
//            switch key {
//                case "path":
//                    result.add(other: Path(json: json))
//                default: ()
//            }
//        }
//        return result
//    }
//
//}
//
////struct Point : Drawable {
////    private let position: CGPoint?
////
////    init(_ pos: CGPoint) {
////        position = pos
////    }
////
////    init(json: JSON) {
////        position = json.cgPoint(key: "pos")
////    }
////
////    func draw(into context: CGContext) {
////        //renderer.arc(at: center, radius: radius, startAngle: 0.0, endAngle: twoPi)
////        let rect = CGRect(x: position!.x - 2.0, y: position!.y - 2.0, width: 4.0, height: 4.0);
////        context.addEllipse(in: rect)
////    }
////}
//
//
//
//struct Circle : Drawable {
//    private let center: CGPoint?
//    private let radius: CGFloat?
//
//    private let pointOnCircle: CGPoint
//
//    init(json: JSON) {
//        center = json.cgPoint(key: "center")
//        radius = json.cgFloat(key: "radius")
//
//        pointOnCircle = CGPoint(x: center!.x + radius!, y: center!.y)
//    }
//
//    func draw(into context: CGContext) {
//
////        context.protect {
////            NSColor.gray.set()
////            let pattern: [CGFloat] = [ 1.0, 1.0 ]
////            channel.setLineDash(phase: 0.0, lengths: pattern)
////            channel.move(to: center!)
////            channel.addLine(to: pointOnCircle )
////
////            channel.strokePath()
////        }
////
//
//        //renderer.arc(at: center, radius: radius, startAngle: 0.0, endAngle: twoPi)
//        let rect = CGRect(x: center!.x - radius!, y: center!.y - radius!,
//                          width: radius! * 2.0, height: radius! * 2.0);
//        context.addEllipse(in: rect)
//
////
////        context.protect {
////            Point(center!).draw(into: channel)
////            Point(pointOnCircle).draw(into: channel)
////        }
//
//    }
//}
//
//struct Bezier : Drawable {
//    private let from: CGPoint?
//    private let to: CGPoint?
//    private let ctrl1: CGPoint?
//    private let ctrl2: CGPoint?
//
//    init(json: JSON) {
//        from = json.cgPoint(key: "from")
//        to = json.cgPoint(key: "to")
//        ctrl1 = json.cgPoint(key: "control_1")
//        ctrl2 = json.cgPoint(key: "control_2")
//    }
//
//    func draw(into context: CGContext) {
//
////        channel.protectGState {
////            //NSColor.gray.set()
////            let pattern: [CGFloat] = [ 1.0, 1.0 ]
////            channel.setLineDash(phase: 0.0, lengths: pattern)
////            channel.move(to: from!)
////            channel.addLine(to: ctrl1!)
////            channel.addLine(to: ctrl2!)
////            channel.addLine(to: to!)
////
////            channel.strokePath()
////        }
//
//        if (from != nil) { context.move(to: from!) }
//        context.addCurve(to: to!, control1: ctrl1!, control2: ctrl2!)
//
////        channel.protectGState {
////            Point(from!).draw(into: channel)
////            Point(to!).draw(into: channel)
////            Point(ctrl1!).draw(into: channel)
////            Point(ctrl2!).draw(into: channel)
////        }
//
//
//        //        for point in controlPoints {
//        //            drawBoxAt(point, color: NSColor.blue)
//        //        }
//
//        //    fileprivate func drawBoxAt(_ point: CGPoint, color: NSColor, filled: Bool = true) {
//        //        let rect = boxForPoint(point);
//        //        let context = currentContext
//        //
//        //        protectGState {
//        //            context.addEllipse(in: rect)
//        //            color.set()
//        //
//        //            if filled {
//        //                context.fillPath()
//        //            } else {
//        //                context.strokePath()
//        //            }
//        //        }
//        //    }
//
//    }
//}
//
////struct Path : Shape {
////    //var mode: ShapeMode
////
////    var fillColor: CGColor?
////    var lineColor: CGColor?
////    var lineWidth: CGFloat = 3.0
////
////    private var elements: [Drawable] = []
////
////    init(json: JSON) {
////       // mode = .show
////        lineColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.222, 0.617, 0.976, 1.0])!
////
////        for key in json.keys {
////            switch key {
////                case "circle":
////                    elements.append(Circle(json: json.jsonFor(key: key)))
////                case "bezier":
////                    elements.append(Bezier(json: json.jsonFor(key: key)))
//////                case "color":
//////                    color = json.cgFloat(key: key)
////                case "lineWidth":
////                    let lw = json.cgFloat(key: key)
////                    if (lw != nil) { lineWidth = lw! }
////                default: ()
////            }
////        }
////    }
////
////    func draw(into context: CGContext) {
////        for f in elements {
////            f.draw(into: context)
////        }
////        context.setStrokeColor(lineColor!)
////        context.setLineWidth(lineWidth)
////        context.strokePath()
////    }
////}
//
//
//
//
//
