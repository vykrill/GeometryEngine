// Double.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 6th, 2020
//

import Foundation

extension Double {
    /// Rounds the number to the specified number of places.
    /// - parameter place: The place to round the number too.
    /// - returns: The rounded number.
    func rounded(toPlace place: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Double { 
        let factor = pow(10.0, Double(place))
        return (self * factor).rounded(rule) / factor
    }

    /// Checks if two numbers are approximately equal.
    static func ~=(_ left: Double, _ right: Double) -> Bool {
        areApproximatelyEquals(left, and: right, precision: 5)
    }
}