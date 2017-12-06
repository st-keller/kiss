//
//  Pen.swift
//  kiss
//
//  Created by Stefan Keller on 05.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

// to draw something you'll have to have a pen, a notion of what to draw and a canvas to draw on
protocol Drawable {
    func draw(_ draft: Sketch, on canvas: Canvas)
}

protocol Pen : Drawable {
    var lineWidth: Number {get}
    var lineColor: Color? {get}
    var linePattern: [Number]? {get}
    var fillColor: Color? {get}
    
    func draw(_ draft: Sketch, on canvas: Canvas)
}

extension Pen {
    func draw(_ draft: Sketch, on canvas: Canvas) {
        canvas.protect {
            draft.sketchTo(on: canvas)
            canvas.strokePath(with: self)
        }
    }
}

struct DarkPen : Pen {
    var lineWidth: Number = 2.0
    var lineColor: Color? = Color(gray: 0.1, alpha: 1.0)
    var linePattern: [Number]? = nil
    var fillColor: Color? = nil
}

struct DottedLightPen : Pen {
    var lineWidth: Number = 1.0
    var lineColor: Color? = Color(gray: 0.7, alpha: 1.0)
    var linePattern: [Number]? = [ 2.0, 2.0 ]
    var fillColor: Color? = nil
}
