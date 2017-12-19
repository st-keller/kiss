//
//  AppDelegate.swift
//  kiss
//
//  Created by Stefan Keller on 14.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

//let json = JSON(from: "{ \"circle\": { \"center\": { \"x\": 120.5, \"y\": 120.5 }, \"radius\": 50.75 } }")

//let json = JSON(from: "{ \"bezier\": { \"from\": { \"x\": 17.0, \"y\": 400.0 }, \"to\": { \"x\": 175.0, \"y\": 20.0 }, \"control_1\": { \"x\": 330.0, \"y\": 275.0 }, \"control_2\": { \"x\": 150.0, \"y\": 371.0 } } }")

//let json = JSON(from: "{ \"path\": { \"bezier\": { \"from\": { \"x\": 17.0, \"y\": 400.0 }, \"to\": { \"x\": 175.0, \"y\": 20.0 }, \"control_1\": { \"x\": 330.0, \"y\": 275.0 }, \"control_2\": { \"x\": 150.0, \"y\": 371.0 } }, \"circle\": { \"center\": { \"x\": 120.5, \"y\": 120.5 }, \"radius\": 50.75 } } }")

//let json = JSON(from: "{ \"path\": { \"lineWidth\": 2.0, \"circle\": { \"center\": { \"x\": 120.5, \"y\": 120.5 }, \"radius\": 50.75 }, \"bezier\": { \"from\": { \"x\": 17.0, \"y\": 400.0 }, \"to\": { \"x\": 375.0, \"y\": 20.0 }, \"control_1\": { \"x\": 130.0, \"y\": 475.0 }, \"control_2\": { \"x\": 150.0, \"y\": 271.0 } } } }")
//let scene = SceneBuilder(by: json).build();

let drawingArea = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)

var scene = Scene(by: Path(by: CubicCurve(from: Position(x:17.0, y:400.0),
                                          to: Position(x:375.0, y:20.0),
                                          control1: Position(x: 130.0, y: 475.0),
                                          control2: Position(x: 150.0, y:271.0)))
                                .line(to: Position(x:50.0, y:20.0))
                                .line(to: Position(x:17.0, y:380.0)))


class MasterView: NSView {

    var scene: Scene
    
    init(scene: Scene) {
        self.scene = scene
        super.init(frame: drawingArea)
    }
    
    required init?(coder decoder: NSCoder) {
        self.scene = Scene()
        super.init(coder: decoder)
    }
    
//    init(draw: @escaping (CGContext)->()) {
//        super.init(frame: drawingArea)
//        self.draw = draw
//        self.setNeedsDisplay(drawingArea)
//    }
    
//    required init?(coder decoder: NSCoder) {
//        super.init(coder: decoder)
//    }
//
    override func draw(_ bounds: CGRect) {
        let canvas = (NSGraphicsContext.current)!.cgContext
        canvas.protect {
            scene.draw(on: canvas)
        }
    }
    //var draw: (CGContext)->() = { _ in () }
    
    
    override func mouseDown (with event: NSEvent) {
//        let localPoint = convert(event.locationInWindow, from: nil)
//
//        for (index, point) in controlPoints.enumerated() {
//            let box = boxForPoint(point).insetBy(dx: -10.0, dy: -10.0)
//
//            if box.contains(localPoint) {
//                draggingIndex = index
//                break
//            }
//        }
    }

    override func mouseDragged (with event: NSEvent) {
//        let localPoint = convert(event.locationInWindow, from: nil)

//
//        guard let index = draggingIndex else { return }
//
//
//        controlPoints[index] = localPoint
        needsDisplay = true
    }


    override func mouseUp (with event: NSEvent) {
//        draggingIndex = nil
    }

    
    
    
    
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    @IBOutlet weak var window: NSWindow!
    
    let mainView = MasterView(scene: scene)

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

