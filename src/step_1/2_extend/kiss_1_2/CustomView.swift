//
//  CustomView.swift
//  kiss_1_2
//
//  Created by Stefan Keller on 10.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

class CustomView : NSView {
    
    //var textField: NSTextField?
    
    //has to be there:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //our preferred initializer:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.green.cgColor
    }
    
    // we use a flipped coordinate system primarily to get better alignment when scrolling
    override var isFlipped: Bool { return true; }
    
    // Override the NSView keydown func to read keycode of pressed key
    override func keyDown(with theEvent: NSEvent)
    {
        //Filter Modifier-Flags (the lower 16 bits of the modifier flags are reserved for device-dependent bits):
        let effectiveModifiers = NSEvent.ModifierFlags(rawValue: theEvent.modifierFlags.rawValue & ~0xffff)
        //print ALT, if alt -key (and only alt-key) was pressed:
        if (effectiveModifiers.contains(.option) && effectiveModifiers.subtracting(.option).isEmpty)  {
            Swift.print("keyDown: ALT!")
            if (theEvent.keyCode == 0x24) {
                Swift.print("keyDown: RETURN!")
                let colorWell = NSColorWell(frame: NSRect(x: 0, y: 80, width: 100, height: 20))
                colorWell.target = self
                colorWell.action = #selector(self.processAction)
                //colorWell.tag = entityId
                colorWell.color = NSColor(cgColor: self.layer?.backgroundColor ?? NSColor.green.cgColor)!
                addSubview(colorWell)
            }
        }
        return
    }
    
    @objc func processAction(sender: NSColorWell) {
        self.layer?.backgroundColor = sender.color.cgColor
    }
    
}
