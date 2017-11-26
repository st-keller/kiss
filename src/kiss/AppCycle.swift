////
////  AppCycle.swift
////  kiss
////
////  Created by Stefan Keller on 15.11.17.
////  Copyright © 2017 Stefan Keller. All rights reserved.
////
//
//import Foundation
//
//class AppCycle {
//    static func setUp(renderer: Renderer) {
//        let defaultData = renderer.setUp()
//        //AppState.permit(defaultData)
//        Query.subscribe(renderer: renderer)
//        Dispatcher.newEvents(events: defaultData)
//    }
//    static func tearDown(renderer: Renderer) {
//        //AppState.forbid(defaultData)
//        //Query.unsubscribe(renderer: renderer)
//        renderer.tearDown()
//    }
//}
//
//
//// Dispatcher
////   - recieves Events
////   - has to inform AppState
//// May know what events are sent by whom (doesn't know now)
//class Dispatcher {
//    static func newEvent(event: String, data: Data) {
//        //process event
//        var (currentstate, currentData) = AppState.getState()
//        currentData[event] = data
//        //change app-state
//        AppState.progress(state: currentstate, data: currentData) //next Domino
//    }
//
//    static func newEvents(events: [String:Data]) {
//        //process event
//        var (currentstate, currentData) = AppState.getState()
//        currentData.merge(events) { (current, _) in current }
//        //change app-state
//        AppState.progress(state: currentstate, data: currentData) //next Domino
//    }
//}
//
////  ||
////  \/
//
//// AppState
////   - recieves Changes from Dispatcher
////   - has to trigger Query
//class AppState {
//    private static var history: Array<[String:Data]> = [[:]]
//    static func getState() -> (state: Int, data:[String:Data] ) {
//        let state = history.count;
//        return (state, history[history.count-1])
//    }
//    static func get(keys: Array<String>) -> (state: Int, data:[String:Data] ) {
//        let state = history.count
//        var data: [String:Data] = [:]
//        if (state > 0) {
//            data = history[state-1].filter{keys.contains($0.key)}
//        }
//        return (state, data)
//    }
//    static func progress(state: Int, data: [String:Data]) {
//        //Todo - state param is currently ignored
//        history.append(data)
//        //Todo - changes may not really be changes
//        Query.informSubcribers(changes: data) //next Domino
//    }
//}
//
////  ||
////  \/
//
//// Query
////   - recieves Changes from AppState
////   - has to inform Renderers
//class Query {
//    private static var subscribedRenderers: Array<Renderer> = []
//    static func subscribe(renderer: Renderer) { //}, forKeys: Array<String>) {
//        subscribedRenderers.append(renderer)
//    }
//    static func informSubcribers(changes: [String:Data]) {
//        for renderer in subscribedRenderers {
//            renderer.render(data: changes) //next Domino
//        }
//    }
//}
//
////  ||
////  \/
//
//protocol Renderer {
//    func setUp() -> [String : Data] // setsUp the renderer
//    func render(data: [String : Data]) //will update view, and will create controls/listeners, wich will fire Events => that starts a new domino-chain!
//    func tearDown() // removes the renderer gracefully from its view
//}
//
//
//// Data-Helper
//extension Bool {
//    func toData() -> Data {
//        var data = Data()
//        if (!self) { data.append(1) };
//        return data
//    }
//}
//
