//
//  Drawable.swift
//  kiss
//
//  Created by Stefan Keller on 02.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

//typealias Number = CGFloat
//typealias Context = CGContext

extension CGContext  {
    
    func protect(_ drawStuff : () -> Void) {
        saveGState ()
        drawStuff()
        restoreGState()
    }
    
    func fillPath() {
        self.fillPath(using: CGPathFillRule.winding)
    }
}

protocol Plottable {
    func plot(into context: CGContext)
}

struct Point : Plottable {
    let x: CGFloat
    let y: CGFloat
    
    init(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
    }
    
    func cgPoint() -> CGPoint {
        return CGPoint(x: x, y: y)
    }

    func distance(to: Point) -> CGFloat {
        let distX = (self.x - to.x)
        let distY = (self.y - to.y)
        return hypot(distX, distY) //eqiv. to "sqrt(distX * distX + distY * distY)"
    }

    func plot(into context: CGContext) {
        context.move(to: self.cgPoint() )
    }

}
