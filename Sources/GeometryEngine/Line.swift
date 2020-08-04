// Line.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 7th, 2020
//

import Foundation

/// A line in 2D space.
///
/// A line is represented by two `Vector2D` instances. It can then be used for composing 
///  polygons. You create a new `Line` by giving its twos points.
///
///     // Creates a line from (0, 0) to (1, 0).
///     let line = Line([0, 0], [1, 0])
struct Line: Equatable, GeometryPrimitive {
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

    /// Checks for intersection with another line.
    /// 
    /// This method is just a shortcut for the `Line.getIntersectionBetween(_: and:)`
    ///          method. These two lines of code are equivalent:
    ///
    ///     let _ = Line.getIntersectionBetween(l1, and l2)
    ///     let _ = l1.intersection(with: l2)
    ///
    /// - parameter line: The line to test intersection with.
    /// - returns: The appropriate `CollisionTestResult` depending of the intersection.
    ///             Check `CollisionTestResult`'s documentation for more detail. 
    func intersection(with line: Line) -> CollisionTestResult { 
        Self.getIntersection(between: self, and: line) 
    }

    // - MARK: Static methods

    /// Checks for intersection between two lines.
    /// - parameters: 
    ///     * line1: The first line.
    ///     * line2: The other line.
    ///
    /// - returns: The appropriate `CollisionTestResult` depending of the intersection.
    ///             Check `CollisionTestResult`'s documentation for more detail. 
    static func getIntersection(between line1: Line, and line2: Line) -> CollisionTestResult {
        if let point = Line.getIntersectionPoint(between: line1, and: line2) {
            // The two lines are not parallel.
            if line1.contains(point) && line2.contains(point) {
                return.point(position: point)
            } else {
                return .none
            }
        } else {
            // The two lines are parallel
            return getOverlap(between: line1, and: line2)
        }
    }

    /// Checks for the intersection point between two lines.
    /// - parameters:
    ///     * line1: The first line.
    ///     * line2: The other line.
    /// - note: The returned point might not be part of either line as they will be 
    ///          considered like infinite lines.
    /// - returns: `nil` if the two lines are parallel, otherwise the intersection point.
    static private func getIntersectionPoint(between line1: Line, and line2: Line) -> Vector2D? {
        // TODO: Correct this method
        guard !line1.vector.isParallel(to: line2.vector) else { return nil }

        // Angle between the two lines.
        var angle1 = abs(line1.angle - line2.angle)
        if angle1 > π {
            angle1 = (2 * π) - angle1
        }
        
        let vector1 = line2.p2 - line1.p1

        let line1i = Line(line1.p2, line1.p1)
        
        // Angle between line1 and vector1.
        var angle2 = abs(line1i.angle - vector1.angle)
        if angle2 > π { angle2 = (2 * π) - angle2 }

        // Length to remove from line2.
        let length = (sin(angle2) * vector1.length) / sin(angle1)
        let vector2 = Vector2D(length: length, angle: line2.angle + π)

        return line2.p2 + vector2
    }

    /// Checks for the overlap between two colinear lines.
    /// - parameters:
    ///     * line1: The first line.
    ///     * line2: The second line.
    /// - returns: `nil` if the two lines are not colinear. If they are, it returns the line 
    ///             composing the overlap. The only exception is when the lenght of the line
    ///             is null; it then returns the point.
    static private func getOverlap(between line1: Line, and line2: Line) -> CollisionTestResult {
        // We first check if the two lines are colinear.
        let testVector: Vector2D = [line2.p1.x - line1.p1.x, line2.p1.y - line1.p1.y]
        guard testVector.isParallel(to: line1.vector) else { return .none }

        // We then ensure there is an overlap.
        let vector: Vector2D = [line1.minX - line2.minX, line1.minY - line2.minY]
        guard !(vector.length > line1.length && vector.length > line2.length) else {
            return .none
        }

        // Finally, we calculate the overlap. 
        // It is from the highest minX/minY to the lowest maxX/maxY.
        let result = Line(
            [max(line1.minX, line2.minX), max(line1.minY, line2.minY)],
            [min(line1.maxX, line2.maxY), min(line1.maxY, line2.maxY)])

        // For clarity, we return a point if the length of the result line is null.
        if result.p1 == result.p2 { return .point(position: result.p1) }

        return .segment(section: result)
    }
    
    // MARK: Geometry Primitive

    /// Returns whether or not the specified point is contained in the line's container shape.
    ///
    /// The result depends on the order the lines were created in; clockwise or counter-clockwise. 
    ///  To evaluate this, we create a test vector from `p1` to the test point. We then calculate the
    ///  smallest angle between the test vector and the line. In a clockwise polygon, this new angle 
    ///  must be to the left of the line. It is the opposite in a counter-clockwise polygon.
    ///
    /// - parameters:
    ///     * point: The test point.
    ///     * clockwise: If the line was created in a clockwise order. Defaults to `true`.
    /// - returns: `true` if the point is contained in the shape from this line point of view;
    ///             otherwise `false`.
    func isPointInward(_ point: Vector2D, clockwise: Bool = true) -> Bool {

        if self.contains(point) { return true }

         // We make a vector to the point to test.
         let testVector: Vector2D = [point.x - self.p1.x, point.y - self.p1.y]

        // We check the angle of `testVector` relative to the line's angle.
        // We also make sure the result is positive.
        var resultAngle = testVector.angle - Angle.getRelativeAngle(of: self.angle)
        resultAngle += resultAngle < 0 ? 2 * π : 0

        // The result depends on whether or not the lines were created in a clockwise order.
         return clockwise ? (resultAngle >= π && resultAngle <= 2 * π) : resultAngle <= π
    }
    
    var points: [Vector2D] { [p1, p2] }
}
