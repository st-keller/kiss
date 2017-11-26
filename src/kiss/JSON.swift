//
//  JSON.swift
//  kiss
//
//  Created by Stefan Keller on 26.11.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Cocoa

class JSON {
    
    private let json: Any?
    
    init(by definition: Any?) {
        json = definition
    }

    convenience init(from text: String) {
        var definition: Any? = nil
        if let data = text.data(using: .utf8) {
            do {
                definition = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            } catch {
                definition = nil
            }
        }
        self.init(by: definition)
    }
    
    func jsonObject() -> Any? {
        return json
    }
    
    func jsonFor(key: String) -> JSON {
        if let dict = json as? [String: Any] {
            return JSON(by: dict[key])
        }
        return JSON(by: nil)
    }
    
    var keys: [String] {
        get {
            if let dict = json as? [String: Any] {
                var temp: [String] = []
                for key in dict.keys {
                    temp.append(key)
                }
                return temp
            }
            return []
        }
    }
    
    func cgFloat(key: String) -> CGFloat? {
        guard
            let dict = json as? [String : Any],
            let dbl = dict[key] as? Double
            else {
                return nil
            }
        return CGFloat(dbl)
    }
    
    func cgPoint(key: String) -> CGPoint? {
        guard
            let dict = json as? [String : Any],
            let point = dict[key] as? [String : Double],
            let double_x = point["x"],
            let double_y = point["y"]
            else {
                return nil
        }
        return CGPoint(x: CGFloat(double_x), y: CGFloat(double_y))
    }
    
}
