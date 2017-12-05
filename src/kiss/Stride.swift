//
//  Stride.swift
//  kiss
//
//  Created by Stefan Keller on 02.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

protocol Stride : Plottable {
    var start: Point {get}
    var end: Point {get}
    var controls: [Point] {get}
    var length: CGFloat {get}
    
    // plot to the end of the stride (without considering where we start from)
    func plot(into context: CGContext)
}

extension Stride {
    
    func plotControlGraph(into context: CGContext)  {
        for ctrl in controls {
            context.addLine(to: ctrl.cgPoint())
        }
        context.addLine(to: end.cgPoint())
    }

}

struct Line : Stride {

    let start: Point
    let end: Point
    let controls: [Point] = []
    let length: CGFloat
    
    init(start: Point, end: Point) {
        self.start = start
        self.end = end
        self.length = start.distance(to: end)
    }
    
    func plot(into context: CGContext) {
        context.addLine(to: end.cgPoint())
    }
    
}

struct QuadCurve : Stride {
    
    let start: Point
    let end: Point
    let controls: [Point]
    var length: CGFloat { get { return quadCurveLength() } }
    
    init(start: Point, end: Point, control: Point) {
        self.start = start
        self.end = end
        self.controls = [control]
    }
    
    func plot(into context: CGContext) {
        context.addQuadCurve(to: end.cgPoint(), control: controls[0].cgPoint())
    }
    
    private func quadCurveLength() -> CGFloat {
        var approxDist: CGFloat = 0
        let approxSteps: CGFloat = 100
        for i in 0..<Int(approxSteps) {
            let t0 = CGFloat(i) / approxSteps
            let t1 = CGFloat(i+1) / approxSteps
            let a = quadCurvePoint(t: t0, p0: start, p1: end, c1: controls[0])
            let b = quadCurvePoint(t: t1, p0: start, p1: end, c1: controls[0])
            approxDist += a.distance(to: b)
        }
        return approxDist
    }
    
    private func quadCurvePoint(t: CGFloat, p0: Point, p1: Point, c1: Point) -> Point {
        let x = quadCurveValue(t: t, p0: p0.x, p1: p1.x, c1: c1.x)
        let y = quadCurveValue(t: t, p0: p0.y, p1: p1.y, c1: c1.y)
        return Point(x: x, y: y)
    }
    
    private func quadCurveValue(t: CGFloat, p0: CGFloat, p1: CGFloat, c1: CGFloat) -> CGFloat {
        var value: CGFloat = 0.0
        // (1-t)^2 * p0 + 2 * (1-t) * t * c1 + t^2 * p1
        value += pow(1-t, 2) * p0
        value += 2 * (1-t) * t * c1
        value += pow(t, 2) * p1
        return value
        
    }
    
    
}

struct CubicCurve : Stride {

    let start: Point
    let end: Point
    let controls: [Point]
    var length: CGFloat { get { return cubicCurveLength() } }
    
    init(start: Point, end: Point, control1: Point, control2: Point) {
        self.start = start
        self.end = end
        self.controls = [control1, control2]
    }
    
    func plot(into context: CGContext) {
        context.addCurve(to: end.cgPoint(), control1: controls[0].cgPoint(), control2: controls[1].cgPoint())
    }
    
    private func cubicCurveLength() -> CGFloat {
        var approxDist: CGFloat = 0
        let approxSteps: CGFloat = 100
        for i in 0..<Int(approxSteps) {
            let t0 = CGFloat(i) / approxSteps
            let t1 = CGFloat(i+1) / approxSteps
            let a = cubicCurvePoint(t: t0, p0: start, c1: controls[0], c2: controls[1], p1: end)
            let b = cubicCurvePoint(t: t1, p0: start, c1: controls[0], c2: controls[1], p1: end)
            approxDist += a.distance(to: b)
        }
        return approxDist
    }

    private func cubicCurvePoint(t: CGFloat, p0: Point, c1: Point, c2: Point, p1: Point) -> Point {
        let x = cubicCurveValue(t: t, p0: p0.x, c1: c1.x, c2: c2.x, p1: p1.x)
        let y = cubicCurveValue(t: t, p0: p0.y, c1: c1.y, c2: c2.y, p1: p1.y)
        return Point(x: x, y: y)
    }

    private func cubicCurveValue(t: CGFloat, p0: CGFloat, c1: CGFloat, c2: CGFloat, p1: CGFloat) -> CGFloat {
        var value: CGFloat = 0.0
        // (1-t)^3 * p0 + 3 * (1-t)^2 * t * c1 + 3 * (1-t) * t^2 * c2 + t^3 * p1
        value += pow(1-t, 3) * p0
        value += 3 * pow(1-t, 2) * t * c1
        value += 3 * (1-t) * pow(t, 2) * c2
        value += pow(t, 3) * p1
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


