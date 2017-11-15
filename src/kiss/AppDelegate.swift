//
//  AppDelegate.swift
//  kiss
//
//  Created by Stefan Keller on 14.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa


extension NSView {
    var currentContext : CGContext {
        get {
            // 10.9 doesn't have a reasonable call for getting the current context
            // that doesn't require jumping through ever-changing opaque pointers.
            let context = NSGraphicsContext.current
            return context!.cgContext
        }
    }
    
    func protectGState(_ drawStuff : () -> Void) {
        currentContext.saveGState ()
        drawStuff()
        currentContext.restoreGState ()
    }
}


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    @IBOutlet weak var window: NSWindow!

    let mainView = PointRenderer(frame: NSMakeRect(0, 0, 1, 1))

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

