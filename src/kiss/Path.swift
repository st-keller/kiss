//
//  Path.swift
//  kiss
//
//  Created by Stefan Keller on 02.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

// to draw something you have to have a notion of what to draw, a pen and a canvas to draw on
protocol Drawable {
    func draw(with pen: Pen, on canvas: Canvas)
}

struct Path: Sketchable, Drawable {
    let curves: [Curve]
    let from: Position
    let to: Position
    let length: Number

    init(by curve: Curve) {
        self.init(curves: [curve], from: curve.from, to: curve.to, length: curve.length)
    }
    
    func line(to: Position) -> Path {
        return add(Line(from: self.to, to: to))
    }
    
    func quadCurve(to: Position, control: Position) -> Path {
        return add(QuadCurve(from: self.to, to: to, control: control))
    }
    
    func cubicCurve(to: Position, control1: Position, control2: Position) -> Path {
        return add(CubicCurve(from: self.to, to: to, control1: control1, control2: control2))
    }

    func sketchTo(on canvas: Canvas) {
        for c in curves {
            c.sketchTo(on: canvas)
        }
    }
    
    func draw(with pen: Pen, on canvas: Canvas) {
        canvas.protect {
            curves[0].from.sketchTo(on: canvas)
            self.sketchTo(on: canvas)
            canvas.strokePath(with: pen)
        }
    }

//    func getVertices(withControls: Bool = false) -> [Position] {
//        var vertices: [Position] = [elements[0].from]
//        for e in elements {
//            if (withControls) { for c in e.controls { vertices.append(c) } }
//            vertices.append(e.to)
//        }
//        return vertices
//    }
    
    private func add(_ curve: Curve) -> Path {
        var curves = self.curves
        curves.append(curve)
        return Path(curves: curves, from: self.from, to: curve.to, length: self.length + curve.length)
    }

    private init(curves: [Curve], from: Position, to: Position, length: Number) {
        self.curves = curves
        self.from = from
        self.to = to
        self.length = length
    }
    

}





//    func controlPath() -> Path {
////        func plotControlGraph(on canvas: Canvas)  {
////            for ctrl in controls {
////                canvas.addLine(to: ctrl)
////            }
////            canvas.addLine(to: to)
////        }
//    }
//
////    func draw(on canvas: Canvas) {
//////        canvas.protect {
//////            canvas.move(to: elements[0].from)
//////            for e in elements {
//////                e.plotControlGraph(on: canvas)
//////            }
//////            DottedLightStylus().draw(on: canvas)
//////        }
////
////        DarkStylus().draw(self, on: canvas)
////
////        //        context.protect {
////        //            elements[0].start.drawBox(into: context)
////        //            for e in elements {
////        //                e.end.drawBox(into: context)
////        //            }
////        //        }
////
////    }


//var mode: ShapeMode
//

//    init(json: JSON) {
//        // mode = .show
//        lineColor = Color(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.222, 0.617, 0.976, 1.0])!
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

