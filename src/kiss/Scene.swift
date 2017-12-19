//
//  Scene.swift
//  kiss
//
//  Created by Stefan Keller on 06.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation



//a scene defines - besides the decoration - places for actors
//places may be restricted: "place for exponent", "place for everything else"

//an arranger may be attached to a place:
//it will arranges the actors if more than one actor wants to occupy a certain place

//elements of the scene (actors as well as decoration) have to be selectabe by pointing at them!
//selected elements may be "changed" (including "replacement") or deleted

// a scene may define no place for actors and may be "decoration only":
// "look - a yello circle, a black path and a (filled) green box!"

struct Scene {
    var decoration: [Drawable] = []
    //var places: [Place]
    
    func draw(on canvas: Canvas) {
        for e in decoration {
            e.draw(with: DarkPen(), on: canvas)
        }
    }

    init() {}
    
    init(by drawable: Drawable) {
        self.decoration = [drawable]
    }
    
}



//extension BezierCurve {
//    override func mouseDown (with event: NSEvent) {
//        let localPoint = convert(event.locationInWindow, from: nil)
//
//        for (index, point) in controlPoints.enumerated() {
//            let box = boxForPoint(point).insetBy(dx: -10.0, dy: -10.0)
//
//            if box.contains(localPoint) {
//                draggingIndex = index
//                break
//            }
//        }
//    }
//
//    override func mouseDragged (with event: NSEvent) {
//        guard let index = draggingIndex else { return }
//
//        let localPoint = convert(event.locationInWindow, from: nil)
//
//        controlPoints[index] = localPoint
//        needsDisplay = true
//    }
//
//
//    override func mouseUp (with event: NSEvent) {
//        draggingIndex = nil
//    }
//}






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
