//
//  BackgroundRenderer.swift
//  kiss_1_3
//
//  Created by Stefan Keller on 10.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

class BackgroundRenderer : NSView, Renderer {
    
    var editModeState: Bool?
    var bgColor: NSColor?
    var colorWell: NSColorWell?
    
    func setUp() -> [String : Data] {
        return ["background" : NSKeyedArchiver.archivedData(withRootObject: NSColor.green),
                "inEditMode" : false.toData()]
    }
    
    func render(data: [String : Data]) {
        updateBgColor(data: data["background"])
        updateEditMode(data: data["inEditMode"])
    }
    
    func tearDown() {
        removeColorWell()
        colorWell = nil
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
    
    private func updateBgColor(data: Data?) {
        if ( data == nil) { return }
        
        let newBgColor = (NSKeyedUnarchiver.unarchiveObject(with: data!)) as? NSColor
        if (newBgColor != nil && newBgColor != bgColor) {
            bgColor = newBgColor!
            self.wantsLayer = true
            self.layer?.backgroundColor = bgColor?.cgColor
        }
    }
    
    private func updateEditMode(data: Data?) {
        if ( data == nil) { return }
        
        let newEditModeState = data?.isEmpty
        if (newEditModeState != nil && newEditModeState != editModeState) {
            editModeState = newEditModeState!
            if (editModeState)! {
                showColorWell()
            } else {
                removeColorWell()
            }
        }
    }
    
    private func showColorWell() {
        //attach a colorWell
        //(create if not already there)
        if (colorWell == nil) {
            colorWell = NSColorWell(frame: NSRect(x: 0, y: 80, width: 100, height: 20))
            colorWell?.target = self
            colorWell?.action = #selector(self.createColorEvent)
            colorWell?.color = bgColor!
        }
        self.addSubview(colorWell!)
    }
    
    private func removeColorWell()
    {
        NSColorPanel.shared.orderOut(nil)
        NSColorPanel.shared.close()
        //Remove Colorwell if created and attached to view:
        if (colorWell != nil) {
            colorWell?.deactivate()
            if  (colorWell?.superview != nil) {
                colorWell?.removeFromSuperview()
            }
        }
    }
    
    @objc func createColorEvent(sender: NSColorWell) {
        Dispatcher.newEvent(event: "background", data: NSKeyedArchiver.archivedData(withRootObject: sender.color))
    }
    
}

