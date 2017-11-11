//
//  AppDelegate.swift
//  kiss_1_1
//
//  Created by Stefan Keller on 09.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

extension NSView {
    func backgroundColor(color: NSColor) {
        wantsLayer = true
        layer?.backgroundColor = color.cgColor
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let myView = NSView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
        myView.backgroundColor(color: NSColor.red)
        window.contentView = myView
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

