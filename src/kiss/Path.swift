//
//  Path.swift
//  kiss
//
//  Created by Stefan Keller on 02.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

struct Path: Sketchable {
    let elements: [Stride]
    let from: Position
    let to: Position
    let length: Number

    init(by stride: Stride, stylus: Stylus) {
        self.init(elements: [stride], from: stride.from, to: stride.to,// stylus: stylus,
                  length: stride.length)
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

    func sketch(on canvas: Canvas) {
        canvas.move(to: elements[0].from)
        for e in elements {
            e.sketch(on: canvas)
        }
    }
    
    func controlPath() -> Path {
//        func plotControlGraph(on canvas: Canvas)  {
//            for ctrl in controls {
//                canvas.addLine(to: ctrl)
//            }
//            canvas.addLine(to: to)
//        }
    }
    
//    func draw(on canvas: Canvas) {
////        canvas.protect {
////            canvas.move(to: elements[0].from)
////            for e in elements {
////                e.plotControlGraph(on: canvas)
////            }
////            DottedLightStylus().draw(on: canvas)
////        }
//
//        DarkStylus().draw(self, on: canvas)
//
//        //        context.protect {
//        //            elements[0].start.drawBox(into: context)
//        //            for e in elements {
//        //                e.end.drawBox(into: context)
//        //            }
//        //        }
//
//    }

    private func add(_ stride: Stride) -> Path {
        var strides = self.elements
        strides.append(stride)
        return Path(elements: strides,
                    from: self.from, to: stride.to, //stylus: self.stylus,
                          length: self.length + stride.length)
    }

    private init(elements: [Stride], from: Position, to: Position, // stylus: Stylus,
                 length: Number) {
        self.elements = elements
        self.from = from
        self.to = to
        self.length = length
        
        //self.stylus = stylus
    }
    

}




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

