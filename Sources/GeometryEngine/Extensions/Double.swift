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

     /// Checks the equality between two `Double` with a lower precision.
    /// - parameters:
    ///     * n1: The first number to compare.
    ///     * n2: The second number to compare.
    ///     * precision: the precision to keep for the equality. Equals to `5` by default.
    /// - returns: `true` if the numbers are approximately equal, otherwise `false`.
    static func areApproximatelyEqual(_ n1: Double, and n2: Double, precision: Int = 5) -> Bool {
         n1.rounded(toPlace: precision) == n2.rounded(toPlace: precision)
    }

    /// Checks if two numbers are approximately equal.
    static func ~=(_ left: Double, _ right: Double) -> Bool {
        areApproximatelyEqual(left, and: right, precision: Self.equalityPrecision)
    }

    /// The level of precision used by the `~=` operator.
    ///
    /// You might also use the `areApproximatelyEqual(_: and:)` method in common.swift for temporary change in precision.
    static var equalityPrecision = 5
    /// The default value of `equalityPrecision`.
    static let defaultEqualityPrecision = 5
}