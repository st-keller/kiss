//
//  Stride.swift
//  kiss
//
//  Created by Stefan Keller on 02.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

protocol Line : Sketch {
    var from: Position {get}
    var to: Position {get}
    var controls: [Position] {get}
    var length: Number {get}
    
    // sketch to the end of the stride (without considering where we start from)
    func sketchTo(on canvas: Canvas)
}

struct LineSegment : Line {

    let from: Position
    let to: Position
    let controls: [Position] = []
    let length: Number
    
    init(from: Position, to: Position) {
        self.from = from
        self.to = to
        self.length = from.distance(to: to)
    }
    
    func sketchTo(on canvas: Canvas) {
        canvas.addLineSegment(to: to)
    }
    
}

struct QuadCurve : Line {
    
    let from: Position
    let to: Position
    let controls: [Position]
    var length: Number { get { return quadCurveLength() } }
    
    init(from: Position, to: Position, control: Position) {
        self.from = from
        self.to = to
        self.controls = [control]
    }
    
    func sketchTo(on canvas: Canvas) {
        canvas.addQuadCurve(to: to, control: controls[0])
    }
    
    private func quadCurveLength() -> Number {
        var approxDist: Number = 0
        let approxSteps: Number = 100
        for i in 0..<Int(approxSteps) {
            let t0 = Fraction(Number(i) / approxSteps)
            let t1 = Fraction(Number(i+1) / approxSteps)
            let a = quadCurvePoint(t: t0, p0: from, p1: to, c1: controls[0])
            let b = quadCurvePoint(t: t1, p0: from, p1: to, c1: controls[0])
            approxDist += a.distance(to: b)
        }
        return approxDist
    }
    
    private func quadCurvePoint(t: Fraction, p0: Position, p1: Position, c1: Position) -> Position {
        let x = quadCurveValue(t: t, p0: p0.x, p1: p1.x, c1: c1.x)
        let y = quadCurveValue(t: t, p0: p0.y, p1: p1.y, c1: c1.y)
        return Position(x: x, y: y)
    }
    
    private func quadCurveValue(t: Fraction, p0: Number, p1: Number, c1: Number) -> Number {
        var value: Number = 0.0
        // (1-t)^2 * p0 + 2 * (1-t) * t * c1 + t^2 * p1
        value += ((!t)^2) * p0
        value += 2 * (!t) * t * c1
        value += (t^2) * p1
        return value
    }

}

struct CubicCurve : Line {

    let from: Position
    let to: Position
    let controls: [Position]
    var length: Number { get { return cubicCurveLength() } }
    
    init(from: Position, to: Position, control1: Position, control2: Position) {
        self.from = from
        self.to = to
        self.controls = [control1, control2]
    }
    
    func sketchTo(on canvas: Canvas) {
        canvas.addCubicCurve(to: to, control1: controls[0], control2: controls[1])
    }
    
    private func cubicCurveLength() -> Number {
        var approxDist: Number = 0
        let approxSteps: Number = 100
        for i in 0..<Int(approxSteps) {
            let t0 = Fraction( Number(i) / approxSteps)
            let t1 = Fraction( Number(i+1) / approxSteps)
            let a = cubicCurvePoint(t: t0, p0: from, c1: controls[0], c2: controls[1], p1: to)
            let b = cubicCurvePoint(t: t1, p0: from, c1: controls[0], c2: controls[1], p1: to)
            approxDist += a.distance(to: b)
        }
        return approxDist
    }

    private func cubicCurvePoint(t: Fraction, p0: Position, c1: Position, c2: Position, p1: Position) -> Position {
        let x = cubicCurveValue(t: t, p0: p0.x, c1: c1.x, c2: c2.x, p1: p1.x)
        let y = cubicCurveValue(t: t, p0: p0.y, c1: c1.y, c2: c2.y, p1: p1.y)
        return Position(x: x, y: y)
    }

    private func cubicCurveValue(t: Fraction, p0: Number, c1: Number, c2: Number, p1: Number) -> Number {
        var value: Number = 0.0
        // (1-t)^3 * p0 + 3 * (1-t)^2 * t * c1 + 3 * (1-t) * t^2 * c2 + t^3 * p1
        value += ((!t)^3) * p0
        value += 3 * ((!t)^2) * t * c1
        value += 3 * (!t) * (t^2) * c2
        value += (t^3) * p1
        return value
    }

}

//Better approach (siehe http://steve.hollasch.net/cgindex/curves/cbezarclen.html):
//
//By subdividing the curve at parameter value t you only have to find the length of a full Bezier curve.
//If you denote the length of the control polygon by L1 i.e.:
//L1 = |P0 P1| +|P1 P2| +|P2 P3|
//and the length of the cord by L0 i.e.:
//L0 = |P0 P3|
//then
//L = 1/2*L0 + 1/2*L1
//is a good approximation to the length of the curve, and the difference
//ERR = L1-L0
//is a measure of the error. If the error is to large, then you just subdivide curve at parameter value 1/2, and find the length of each half.
//If m is the number of subdivisions then the error goes to zero as 2^-4m.
//If you dont have a cubic curve but a curve of degree n then you put
//L = (2*L0 + (n-1)*L1)/(n+1)
//
//Jens Gravesen: "Adaptive subdivision and the length of Bezier curves" mat-report no. 1992- 10,
//Mathematical Institute, The Technical University of Denmark.


