//
//  Numbers.swift
//  kiss
//
//  Created by Stefan Keller on 05.12.17.
//  Copyright © 2017 Stefan Keller. All rights reserved.
//

import Foundation

typealias Number = CGFloat  // a lie

extension Number {
    static func * (left: Int, right: Number) -> Number {
        return Number(left) * right
    }

    static func * (left: Number, right: Int) -> Number {
        return left * Number(right)
    }

}

infix operator ^

//A Number between 0 and 1
class Fraction {
    
    private let value: Number
    
    init(_ value: Number) {
        var temp = value
        if (temp < 0) { temp = -temp }
        if (temp > 1) { temp = temp - floor(temp) }
        self.value = temp
    }

    static prefix func ! (fraction: Fraction) -> Fraction {
        return Fraction(1.0 - fraction.value) // "inversion"
    }
    
    static prefix func - (fraction: Fraction) -> Fraction {
        return fraction //cannot be negative!
    }

    static func - (left: Int, right: Fraction) -> Number {
        return Number(left) - right.value
    }

    static func - (left: Fraction, right: Int) -> Number {
        return left.value - Number(right)
    }

    static func * (left: Number, right: Fraction) -> Number {
        return left * right.value
    }

    static func * (left: Fraction, right: Number) -> Number {
        return left.value * right
    }
    
    static func ^ (left: Fraction, right: Int) -> Number {
        return pow(left.value, Number(right))
    }

}
