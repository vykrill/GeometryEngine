// Line.swift
// Created by Jérémy Goyette
// For GeometryEngine
// July 5th, 2020
//

protocol Geometry {
    /// The basic geometry which compose the shape.
    var primitives: [GeometryPrimitive] { get }
    
    var vertices: [Vector2D] { get }

    /// If the primitives are created in a clockwise order or not. Usefull for collision detection.
    static var clockwise: Bool { get }
    
    /// Returns whether or not this geometry contains the specified point.
    func contains(_ point: Vector2D) -> Bool
    
    func contains(_ points: [Vector2D]) -> [CollisionTestResult]
    
    /// Returns whether or not there is a collision between two shapes.
    func intersection(with geometry: Geometry) -> [CollisionTestResult]
    
    func collision(with geometry: Geometry) -> [CollisionTestResult]
}

// MARK: Default implementations
extension Geometry {
    
    var vertices: [Vector2D] {
        var returnValue = [Vector2D]()
        for primitive in self.primitives {
            for point in primitive.vertices {
                if !returnValue.contains(point) {
                    returnValue.append(point)
                }
            }
        }
        
        return returnValue
    }
    
    func contains(_ point: Vector2D) -> Bool {

        guard primitives.count > 0 else {
            return false
        }

        for primitive in self.primitives {
            if !primitive.isPointInward(point, clockwise: Self.clockwise) {
                return false
            }
        }
        return true
    }
    
    func contains(_ points: [Vector2D]) -> [CollisionTestResult] {
        var result = [CollisionTestResult]()
        for point in points {
            if self.contains(point) {
                result.append(.point(position: point))
            }
        }
        return result
    }

    func intersection(with geometry: Geometry) -> [CollisionTestResult] {
        guard self.primitives.count > 0 && geometry.primitives.count > 0 else {
            return []
        }

        var results = [CollisionTestResult]()

        for primitive in self.primitives {
            for otherPrimitive in geometry.primitives {
                let result = CommonFunctions.intersection(between: primitive, and: otherPrimitive)
                if result != .none {
                    results.append(result)
                }
            }
        }

        return results
    } 
    
    func collision(with geometry: Geometry) -> [CollisionTestResult] {
        // We first collect the lines intersections
        var results = self.intersection(with: geometry)
        
        // current shape points in geometry
        results.append(contentsOf: geometry.contains(self.vertices))
        // geometry points in self
        results.append(contentsOf: self.contains(geometry.vertices))
        
        return results
    }
}
