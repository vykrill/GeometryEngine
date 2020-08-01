// Line.swift
// Created by Jérémy Goyette
// For GeometryEngine
// July 5th, 2020
//

protocol Geometry {
    var primitives: [GeometryPrimitive] { get }

    static var clockwise: Bool { get }
    
    /// Returns whether or not this geometry contains the specified point.
    func contains(_ point: Vector2D) -> Bool
    /// Returns whether or not there is a collision between two shapes.
    func intersection(with geometry: Geometry) -> [CollisionTestResult]
}

// MARK: Default implementations
extension Geometry {
    func contains(_ point: Vector2D) -> Bool {
        for primitive in self.primitives {
            if !primitive.isPointInward(point, clockwise: Self.clockwise) {
                return false
            }
        }
        return true
    }
}