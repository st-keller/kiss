//
//  PointRenderer.swift
//  kiss
//
//  Created by Stefan Keller on 14.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

class PointRenderer: NSView {

//    var x = 7
//    var y = 3
    
    let point: CGPoint = CGPoint(x: 170.0, y: 130.0)
    let color: NSColor = NSColor.blue
    
    //var dragging: Bool = false
    
    fileprivate let BoxSize: CGFloat = 8.0
    
    fileprivate func drawBoxAt(_ point: CGPoint, color: NSColor, filled: Bool = true) {
        let rect = CGRect(x: point.x - BoxSize / 2.0,
                          y: point.y - BoxSize / 2.0,
                          width: BoxSize, height: BoxSize);

        let context = currentContext
        
        protectGState {
            context.addEllipse(in: rect)
            color.set()
            
            if filled {
                context.fillPath()
            } else {
                context.strokePath()
            }
        }
        
//        protectGState {
//            context.addEllipse(in: rect)
//            NSColor.black.set()
//            context.strokePath()
//        }
    
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        drawBoxAt(point, color: color)
    }

}


