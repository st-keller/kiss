//
//  Canvas.swift
//  kiss
//
//  Created by Stefan Keller on 05.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

typealias Color = CGColor //another lie
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
    
    func strokePath(with: Stylus)
    //func fillPath(with: Stylus)
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

    func strokePath(with stylus: Stylus) {
        if (stylus.linePattern != nil) { self.setLineDash(phase: 0.0, lengths: stylus.linePattern!) }
        if (stylus.lineColor != nil) { self.setStrokeColor(stylus.lineColor!) }
        self.setLineWidth(stylus.lineWidth)
        self.strokePath()
    }

//    func fillPath() {
//        self.fillPath(using: CGPathFillRule.winding)
//    }
    
}
