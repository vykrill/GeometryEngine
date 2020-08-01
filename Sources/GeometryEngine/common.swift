// common.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 5th, 2020
//
// contains global variables commonly used in the Geometry Engine

import Foundation

/// The constant pi, in a shorter form.
let π = Double.pi

/// Returns the intersection between two `GeometryPrimitive`.
///
/// Currently, this function support intersection between these primitive pairs:
/// * `Line` and `Line`
/// 
/// - returns: `.none` if intersection detection between the two primitives is not supported, 
///             otherwise the intersection found. Note that supported primitives can also 
///             return `.none` if no collision is found.
func intersection(between primitive1: GeometryPrimitive, and primitive2: GeometryPrimitive) -> CollisionTestResult {
    switch (primitive1, primitive2) {
    case (let line1 as Line, let line2 as Line):
        return line1.intersection(with: line2)
    default:
        return .none
    }
}