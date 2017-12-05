//
//  Stylus.swift
//  kiss
//
//  Created by Stefan Keller on 05.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

// to draw something you'll have to have a notion of what to draw and a stylus
protocol Drawable {
    func draw(_ draft: Sketchable, on canvas: Canvas)
}

protocol Stylus : Drawable {
    var lineWidth: Number {get}
    var lineColor: Color? {get}
    var linePattern: [Number]? {get}
    var fillColor: Color? {get}
    
    func draw(_ draft: Sketchable, on canvas: Canvas)
}

extension Stylus {
    func draw(_ draft: Sketchable, on canvas: Canvas) {
        canvas.protect {
            draft.sketch(on: canvas)
            canvas.strokePath(with: self)
        }
    }
}

struct DarkStylus : Stylus {
    var lineWidth: Number = 2.0
    var lineColor: Color? = Color(gray: 0.1, alpha: 1.0)
    var linePattern: [Number]? = nil
    var fillColor: Color? = nil
}

struct DottedLightStylus : Stylus {
    var lineWidth: Number = 1.0
    var lineColor: Color? = Color(gray: 0.7, alpha: 1.0)
    var linePattern: [Number]? = [ 2.0, 2.0 ]
    var fillColor: Color? = nil
}
