//
//  Drawable.swift
//  kiss
//
//  Created by Stefan Keller on 02.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

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

protocol Drawable {
    func draw(into context: CGContext)
}

struct Point : Drawable {
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

    func draw(into context: CGContext) {
        context.move(to: self.cgPoint() )
    }

    func drawBox(into context: CGContext) {

        let BoxSize: CGFloat = 4.0
        
        context.protect {
            let rect = CGRect(x: self.x - BoxSize / 2.0,
                              y: self.y - BoxSize / 2.0,
                              width: BoxSize, height: BoxSize)
            context.addEllipse(in: rect)
            //color.set()

//            if filled {
//                context.fillPath()
//            } else {
                context.strokePath()
//            }
        }
    }

}
