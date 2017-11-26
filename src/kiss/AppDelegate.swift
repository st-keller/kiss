//
//  AppDelegate.swift
//  kiss
//
//  Created by Stefan Keller on 14.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

//extension NSView {
//    var currentContext : CGContext {
//        get {
//            // 10.9 doesn't have a reasonable call for getting the current context
//            // that doesn't require jumping through ever-changing opaque pointers.
//            let context = NSGraphicsContext.current
//            return context!.cgContext
//        }
//    }
//
//    func protectGState(_ drawStuff : () -> Void) {
//        currentContext.saveGState ()
//        drawStuff()
//        currentContext.restoreGState ()
//    }
//}

//let json = JSON(from: "{ \"circle\": { \"center\": { \"x\": 120.5, \"y\": 120.5 }, \"radius\": 50.75 } }")

//let json = JSON(from: "{ \"bezier\": { \"from\": { \"x\": 17.0, \"y\": 400.0 }, \"to\": { \"x\": 175.0, \"y\": 20.0 }, \"control_1\": { \"x\": 330.0, \"y\": 275.0 }, \"control_2\": { \"x\": 150.0, \"y\": 371.0 } } }")

let json = JSON(from: "{ \"bezier\": { \"from\": { \"x\": 17.0, \"y\": 400.0 }, \"to\": { \"x\": 175.0, \"y\": 20.0 }, \"control_1\": { \"x\": 330.0, \"y\": 275.0 }, \"control_2\": { \"x\": 150.0, \"y\": 371.0 } }, \"circle\": { \"center\": { \"x\": 120.5, \"y\": 120.5 }, \"radius\": 50.75 } }")


let drawingArea = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)
let shape = ShapeBuilder(by: json).build();

class MasterView: NSView {
    init(draw: @escaping (CGContext)->()) {
        super.init(frame: drawingArea)
        self.draw = draw
        self.setNeedsDisplay(drawingArea)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func draw(_ bounds: CGRect) {
        let context = (NSGraphicsContext.current)!.cgContext
        context.saveGState()
        draw(context)
        context.restoreGState()
    }
    var draw: (CGContext)->() = { _ in () }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    @IBOutlet weak var window: NSWindow!
    
    let mainView = MasterView() { shape.draw(into: $0) }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        // Make us a NSWindowDelegate
        window.delegate = self
        // Set our Renderer as contentView
        window.contentView = mainView
        // Make sure that key-events are sent to our view:
        window.makeFirstResponder(mainView)
        
       // AppCycle.setUp(renderer: mainView)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

