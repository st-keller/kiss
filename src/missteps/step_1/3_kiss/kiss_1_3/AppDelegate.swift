//
//  AppDelegate.swift
//  kiss_1_3
//
//  Created by Stefan Keller on 10.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    let mainView = BackgroundRenderer(frame: NSMakeRect(0, 0, 500, 500))
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Make us a NSWindowDelegate
        window.delegate = self
        // Set our Renderer as contentView
        window.contentView = mainView
        // Make sure that key-events are sent to our view:
        window.makeFirstResponder(mainView)
        
        AppCycle.setUp(renderer: mainView)
        
    }
    
    func windowWillClose(_ notification: Notification) {
        AppCycle.tearDown(renderer: mainView)
        NSApplication.shared.terminate(self)
    }
}
