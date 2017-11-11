//
//  AppDelegate.swift
//  kiss_1_1
//
//  Created by Stefan Keller on 09.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let myView = CustomView(frame: NSMakeRect(0, 0, 500, 500))
        window.contentView = myView
        
        // Make sure that key-events are sent to our view:
        window.makeFirstResponder(myView)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        NSApplication.shared.terminate(self)
    }
    
    
}

