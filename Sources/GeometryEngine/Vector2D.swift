// Vector2D.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 5th, 2020
//

import Foundation

/// A vector in 2D space. It can be used for describing position and disrection or for various mathematical calculations.
/// You can create a new instance by using an arry litteral:
///
///     let v1: Vector2D = [0.0, 1.0]
///
@dynamicMemberLookup
struct Vector2D {
    private var storage = SIMD2<Double>()

    // - MARK: @dynamicMemberLookup
    subscript(dynamicMember keyPath: KeyPath<SIMD2<Double>, Double>) -> Double { storage[keyPath: keyPath] }
}