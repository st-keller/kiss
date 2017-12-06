//
//  Shape.swift
//  kiss
//
//  Created by Stefan Keller on 25.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

// Because a Shape (which has an area it covers) cannot be drawn at a (dimensionless) point,
// you have to define, which point of the 2-dim Shape is the one that will end up at the given position.
// This Point is called the "AnchorPoint". It defines how a Shape should deal with a position.
// We define it by two percentages
struct AnchorPoint {
    var x: Number
    var y: Number
}

struct Shape : Drawable {
    let paths: [Path]
    let size: Size
    let anchor: AnchorPoint
    let matrix: TransformMatrix
    
    init(by path: Path) {
        self.paths = [path]
        self.size = Size(width: 1.0, height: 1.0)
        self.anchor = AnchorPoint(x:0.5, y:0.5)
        self.matrix = TransformMatrix.identity
    }
 
    func draw(with pen: Pen, on canvas: Canvas) {
        canvas.protect {
            for p in paths {
                p.draw(with: pen, on: canvas)
            }
        }
    }

}

//func drawBox(into context: CGContext) {
//
//    let BoxSize: CGFloat = 4.0
//
//    context.protect {
//        let rect = CGRect(x: self.x - BoxSize / 2.0,
//                          y: self.y - BoxSize / 2.0,
//                          width: BoxSize, height: BoxSize)
//        context.addEllipse(in: rect)
//        //color.set()
//
//        //            if filled {
//        //                context.fillPath()
//        //            } else {
//        context.strokePath()
//        //            }
//    }
//}
//
//

//struct Box: Shape {
//
//}





