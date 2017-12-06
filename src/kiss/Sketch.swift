//
//  Drawable.swift
//  kiss
//
//  Created by Stefan Keller on 02.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

protocol Sketch {
    func sketchTo(on canvas: Canvas)
}

struct Position : Sketch {
    let x: Number
    let y: Number
    
    init(x: Number, y: Number) {
        self.x = x
        self.y = y
    }

    func distance(to: Position) -> Number {
        let distX = (self.x - to.x)
        let distY = (self.y - to.y)
        return hypot(distX, distY) //eqiv. to "sqrt(distX * distX + distY * distY)"
    }

    func sketchTo(on canvas: Canvas) {
        canvas.move(to: self)
    }

}
