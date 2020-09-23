// Line.swift
// Created by Jérémy Goyette
// For GeometryEngine
// July 5th, 2020
//

protocol Geometry {
    /// The basic geometry which compose the shape.
    var primitives: [GeometryPrimitive] { get }
    
    /// The points composing the shape.
    var vertices: [Vector2D] { get }

    /// If the primitives are created in a clockwise order or not. Usefull for collision detection.
    static var clockwise: Bool { get }
    
    /// Returns whether or not this geometry contains the specified point.
    func contains(_ point: Vector2D) -> Bool
    
    /// Returns the points which are contained in the shape.
    ///
    /// It basically runs the `contains(_:)` method on each point of the array.
    ///
    /// - parameter points: The array of point to test.
    /// - returns: An array of `.point`, which are the points contained in the
    ///             shape.
    func contains(_ points: [Vector2D]) -> [CollisionTestResult]
    
    /// Returns whether or not there is an intersection between two shapes.
    ///
    /// - note: This method only checks for intersections between primitives.
    ///          For a complete collision detection, see the
    ///          `collision(with:)` method.
    /// - parameter geometry: The geometry with which we check for
    ///                         intersection.
    /// - returns: An array of `CollisionTestResult` containing every
    ///             intersection detected.
    func intersection(with geometry: Geometry) -> [CollisionTestResult]
    
    /// Complete collision detection with another shape.
    /// - parameter geometry: The other geometry.
    /// - returns: An array of `CollisionTestResult` containing every
    ///             collision detected.
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

    func getProjectionLines(direction: Vector2D) -> [Line] {
        var result = [Line]()
        for vertice in self.vertices {
            result.append(Line(vertice, vertice + direction))
        }
        return result
    }
}
