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

    static func getIntersectionBetween(_ line1: Line, and line2: Line) -> CollisionTestResult {
        if let point = Line.getIntersectionPointBetween(line1, and: line2) {
            // The two lines are not parallel.
            if line1.contains(point) && line2.contains(point) {
                return.point(position: point)
            } else {
                return .none
            }
        } else {
            // The two lines are parallel
            return getOverlapBetween(line1, and: line2)
        }
    }

    static private func getIntersectionPointBetween(_ line1: Line, and line2: Line) -> Vector2D? {
        guard !line1.vector.isParallel(to: line2.vector) else { return nil }

        // Angle between the two lines
        let angle1 = Angle.getDifferenceBetween(line1.angle, and: line2.angle)
        
        let vector1 = line2.p2 - line1.p1

        // Angle between line1 and vector1
        var angle2 = Angle.getDifferenceBetween(vector1.angle, and: line1.angle)
        if angle2 > π { angle2 -= π }

        // Length to remove from line2
        let length = (sin(angle2) * vector1.length) / sin(angle1)
        let vector2 = Vector2D(length: length, angle: line2.angle + π)

        return line2.p2 + vector2
    }

    static private func getOverlapBetween(_ line1: Line, and line2: Line) -> CollisionTestResult {
        // We first check if the two lines are colinear
        let testVector: Vector2D = [line2.p1.x - line1.p1.x, line2.p1.y - line1.p1.y]
        guard testVector.isParallel(to: line1.vector) else { return .none }

        // We then ensure there is an overlap
        let vector: Vector2D = [line1.minX - line2.minX, line1.minY - line2.minY]
        guard !(vector.length > line1.length && vector.length > line2.length) else {
            return .none
        }

        // Finally, we calculate the overlap. 
        // It is from the highest minX/minY to the lowest maxX/maxY.
        let result = Line(
            [max(line1.minX, line2.minX), max(line1.minY, line2.minY)],
            [min(line1.maxX, line2.maxY), min(line1.maxY, line2.maxY)]
        )

        return .segment(section: result)
    }
}