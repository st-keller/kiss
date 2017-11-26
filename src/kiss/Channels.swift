//
//  Channels.swift
//  kiss
//
//  Created by Stefan Keller on 25.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

protocol Channel {
    func move(to: CGPoint)
    func addCurve(to: CGPoint, control1: CGPoint, control2: CGPoint)
    func ellipse(in rect: CGRect)
    
    func setStrokeColor(_ color: CGColor)
    func setLineWidth(_ width: CGFloat)
    
    func strokePath()
}

extension CGContext : Channel {
    func ellipse(in rect: CGRect) {
        addEllipse(in: rect)
    }
}
