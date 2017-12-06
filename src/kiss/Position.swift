//
//  Position.swift
//  kiss
//
//  Created by Stefan Keller on 02.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

protocol Sketchable {
    func sketchTo(on canvas: Canvas)
}

struct Position : Sketchable, Selectable {
    internal var selected: Bool = false
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
