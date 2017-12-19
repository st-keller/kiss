//
//  Canvas.swift
//  kiss
//
//  Created by Stefan Keller on 05.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

typealias Color = CGColor //another lie
typealias ColorSpace = CGColorSpace

internal func RGBCreateSpace() -> ColorSpace {
    return CGColorSpaceCreateDeviceRGB()
}
internal func CMYKCreateSpace() -> ColorSpace {
    return CGColorSpaceCreateDeviceCMYK()
}
internal func GrayCreateSpace() -> ColorSpace {
    return CGColorSpaceCreateDeviceGray()
}

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
typealias TransformMatrix = CGAffineTransform

typealias Size = CGSize

extension Position {
    func cgPoint() -> CGPoint {
        return CGPoint(x: x, y: y)
    }
}

protocol Canvas {
    func protect(_ drawStuff : () -> Void)
    
    func move(to: Position)
    func addLine(to: Position)
    func addQuadCurve(to: Position, control: Position)
    func addCubicCurve(to: Position, control1: Position, control2: Position)
    
    func strokePath(with: Pen)
    //func fillPath(with: Pen)
}

extension CGContext : Canvas {
    
    func protect(_ drawStuff : () -> Void) {
        saveGState ()
        drawStuff()
        restoreGState()
    }

    func move(to: Position) {
        self.move(to: to.cgPoint() )
    }

    func addLine(to: Position) {
        self.addLine(to: to.cgPoint() )
    }

    func addQuadCurve(to: Position, control: Position) {
        self.addQuadCurve(to: to.cgPoint(), control: control.cgPoint() )
    }
    
    func addCubicCurve(to: Position, control1: Position, control2: Position) {
        self.addCurve(to: to.cgPoint(), control1: control1.cgPoint(), control2: control2.cgPoint() )
    }

    func strokePath(with pen: Pen) {
        if (pen.linePattern != nil) { self.setLineDash(phase: 0.0, lengths: pen.linePattern!) }
        if (pen.lineColor != nil) { self.setStrokeColor(pen.lineColor!) }
        self.setLineWidth(pen.lineWidth)
        self.strokePath()
    }

//    func fillPath() {
//        self.fillPath(using: CGPathFillRule.winding)
//    }
    
}
