//
//  ShapeRenderer.swift
//  kiss_2_1
//
//  Created by Stefan Keller on 10.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

extension NSBezierPath {
    
    public var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)
            switch type {
            case .moveToBezierPathElement:
                path.move(to: points[0])
            case .lineToBezierPathElement:
                path.addLine(to: points[0])
            case .curveToBezierPathElement:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePathBezierPathElement:
                path.closeSubpath()
            }
        }
        
        return path
    }
}

class ShapeRenderer : NSView, Renderer {
    
    // to use a flipped coordinate system do it like this:
    override var isFlipped: Bool { return true; }
    
    let cfChar = "Y" as CFString
    let ctFont = CTFontCreateWithNameAndOptions("HelveticaNeue" as CFString, 50, nil, CTFontOptions.preferSystemFont)
    
    //draw a shape
    let shapelayer = CAShapeLayer()
    
    var editModeState: Bool?
    var font: NSFont?
    
    func setUp() -> [String : Data] {
        defineLayer()
        self.wantsLayer = true
        self.layer?.addSublayer(shapelayer)
        
        return ["font" : NSKeyedArchiver.archivedData(withRootObject: NSFont(name: "DS-Digital", size: 48) ?? NSFont.systemFont(ofSize: NSFont.systemFontSize)),
                "inEditMode" : false.toData()]
    }
    
    func render(data: [String : Data]) {
    }
    
    func tearDown() {
    }
    
    private func defineLayer() {
        let ctGlyph = CTFontGetGlyphWithName(ctFont, cfChar)
        let path = CTFontCreatePathForGlyph(ctFont, ctGlyph, nil)!
        
        //The angle, in radians, by which this matrix rotates the coordinate system axes. In iOS, a positive value specifies counterclockwise rotation
        //and a negative value specifies clockwise rotation.
        let box = path.boundingBox
        var transform = CGAffineTransform(translationX: box.midX, y: box.midY).rotated(by: -45.0 * .pi / 180).translatedBy(x: -box.midX, y: -box.midY)
        let shapePath = path.copy(using: &transform)
        shapelayer.path = shapePath
        
        shapelayer.lineWidth = 2
        shapelayer.strokeColor = NSColor.blue.cgColor
        //layer.fillColor = NSColor.clear.cgColor
        shapelayer.frame = (shapePath?.boundingBox)!
        shapelayer.isGeometryFlipped = true
    }
    
    // Override the NSView keydown func to read keycode of pressed key
    override func keyDown(with theEvent: NSEvent)
    {
        //Filter Modifier-Flags (the lower 16 bits of the modifier flags are reserved for device-dependent bits):
        let effectiveModifiers = NSEvent.ModifierFlags(rawValue: theEvent.modifierFlags.rawValue & ~0xffff)
        //print ALT, if alt -key (and only alt-key) was pressed:
        if (effectiveModifiers.contains(.option) && effectiveModifiers.subtracting(.option).isEmpty)  {
            Swift.print("keyDown: ALT!")
            if (theEvent.keyCode == 0x24) {
                let newMode = !editModeState!
                Dispatcher.newEvent(event: "inEditMode", data: newMode.toData())
            }
        }
    }
 
 
}
