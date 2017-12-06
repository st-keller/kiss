//
//  Selectable.swift
//  kiss
//
//  Created by Stefan Keller on 06.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

protocol Selectable {
    var selected: Bool { get set }
    mutating func deselect()
    mutating func select()
    func isSelected() -> Bool
}

extension Selectable {
    mutating func deselect() { self.selected = false }
    mutating func select() { self.selected = true }
    func isSelected() -> Bool { return self.selected }
}
