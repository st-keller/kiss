//
//  Shape.swift
//  kiss
//
//  Created by Stefan Keller on 25.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

protocol Drawable {
    func draw(into channel: Channel)
//    func drawSelected(into channel: Channel)
//    func drawEditable(into channel: Channel)
}


struct Shape : Drawable {
    
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
    
    func draw(into channel: Channel) {
        for f in elements {
            f.draw(into: channel)
        }
    }
    
    mutating func add(other: Drawable?) {
        if (other != nil) { elements.append(other!) }
    }
    
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

class ShapeBuilder {
    
    let definition: JSON

    init(by definition: JSON) {
        self.definition = definition
    }

    func build() -> Shape {
        var result: Shape = Shape()
        for key in definition.keys! {
            let json = definition.jsonFor(key: key)
            switch key {
                case "circle":
                    result.add(other: Circle(json: json))
                case "bezier":
                    result.add(other: Bezier(json: json))
                default:
                    result.add(other: nil)
            }
            
        }
        return result
    }
    
}

struct Circle : Drawable {
    private let center: CGPoint?
    private let radius: CGFloat?
    
    init(json: JSON) {
        center = json.cgPoint(key: "center")
        radius = json.cgFloat(key: "radius")
    }
    
    func draw(into channel: Channel) {
        //renderer.arc(at: center, radius: radius, startAngle: 0.0, endAngle: twoPi)
        let rect = CGRect(x: center!.x - radius!, y: center!.y - radius!,
                          width: radius! * 2.0, height: radius! * 2.0);
        channel.ellipse(in: rect)
        channel.strokePath()
    }
}

struct Bezier : Drawable {
    private let from: CGPoint?
    private let to: CGPoint?
    private let ctrl1: CGPoint?
    private let ctrl2: CGPoint?

    init(json: JSON) {
        from = json.cgPoint(key: "from")
        to = json.cgPoint(key: "to")
        ctrl1 = json.cgPoint(key: "control_1")
        ctrl2 = json.cgPoint(key: "control_2")
    }
    
    func draw(into channel: Channel) {
        if (from != nil) { channel.move(to: from!) }
        channel.addCurve(to: to!, control1: ctrl1!, control2: ctrl2!)
        channel.strokePath()
    }
}

