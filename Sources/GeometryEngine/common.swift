// common.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 5th, 2020
//
// contains global variables commonly used in the Geometry Engine

import Foundation

/// The constant pi, in a shorter form.
let π = Double.pi

/// Checks the equality between two `Double` with a lower precision.
/// - parameters:
///     * n1: The first number to compare.
///     * n2: The second number to compare.
///     * precision: the precision to keep for the equality. Equals to `5` by default.
/// - returns: `true` if the numbers are approximately equal, otherwise `false`.
func areApproximatelyEquals(_ n1: Double, and n2: Double, precision: Int = 5) -> Bool {
    n1.rounded(toPlace: precision, rule: .towardZero) == n2.rounded(toPlace: precision, rule: .towardZero)
}
