// Line.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 7th, 2020
//

import Foundation

/// A line in 2D space.
///
/// A line is represented by two `Vector2D` instances. It can then be used for composing polygons. You create a new `Line` by giving its twos points.
///
///     // Creates a line from (0, 0) to (1, 0).
///     let line = Line([0, 0], [1, 0])
struct Line: Equatable {
    /// The first point composing the line.
    var p1: Vector2D
    /// The second point composign the line.
    var p2: Vector2D
    
    /// The vector from the first to the second point.
    var vector: Vector2D { p2 - p1 }

    /// The maximum x value of the line.
    var maxX: Double { max(p1.x, p2.x) }
    /// The minimum x value of the line.
    var minX: Double { min(p1.x, p2.x) }

    /// The maximum y value of the line.
    var maxY: Double { max(p1.y, p2.y) }
    /// The minimum y value of the line.
    var minY: Double { min(p1.y, p2.y) }

    /// The angle of the line.
    var angle: Double { vector.angle }
    /// The length of the line.
    var length: Double { vector.length }

    /// Creates a new instance from the given points.
    /// - parameters: 
    ///     * p1: The first point composing the line.
    ///     * p2: The second point composing the line.
    /// - returns: A new line instance.
    init(_ p1: Vector2D, _ p2: Vector2D ) {
        self.p1 = p1
        self.p2 = p2
    }

    /// Checks if the line contains the specified point.
    /// - parameter point: The point to test.
    /// - returns `true` if the point is contained in the line.
    func contains(_ point: Vector2D) -> Bool {
        if p1 == point {
            return true
        } else {
            let testVector = point - p1
            return self.vector.angle ~= testVector.angle && testVector.length <= self.vector.length
        }
    }
}