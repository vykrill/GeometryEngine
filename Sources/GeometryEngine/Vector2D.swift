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
@dynamicMemberLookup
struct Vector2D: Equatable, ExpressibleByArrayLiteral {
    private var storage = SIMD2<Double>()

    /// The length of the vector.
    var length: Double { sqrt(pow(self.x, 2) + pow(self.y, 2)) }

    /// The angle of the vector in radians.
    var angle: Double { 
        var adjustment = 0.0
        switch (self.x, self.y) {
        case (let dX, _) where dX < 0:
            adjustment = π
        case (let dX, let dY) where dX > 0 && dY < 0:
            adjustment = 2 * π
        default:
            break
        }
        return atan(self.y / self.x) + adjustment
    }

    /// Creates a new null vector.
    init() { self.storage = [0.0, 0.0] }

    /// Creates a new vector based on the given length and direction.
    /// - parameters:
    ///     * length: The length of the vector.
    ///     * angle: The angle of the vector.
    init(length: Double, angle: Double) {
        self.storage = [length * cos(angle), length * sin(angle)]
    }

    /// Tests if two vectors' direction are opposite to each other.
    /// - parameter vect: The other vector to test.
    /// - returns: `true` if the vectors' direction are opposite to each other.
    func isOpposite(to vect: Vector2D) -> Bool {
        let angle1 = Angle.getRelativeAngle(of: self.angle)
        let angle2 = Angle.getRelativeAngle(of: vect.angle)

        return abs(angle1 - angle2) == π
    }

    /// Tests if two vectors are parallel.
    /// - parameter vect: The other vector to test.
    /// - returns: `true` if the two vectors are parallel.
    func isParallel(to vect: Vector2D) -> Bool {
        return (self.angle == vect.angle) || self.isOpposite(to: vect)
    }

    // - MARK: @dynamicMemberLookup
    subscript(dynamicMember keyPath: KeyPath<SIMD2<Double>, Double>) -> Double { storage[keyPath: keyPath] }

    // - MARK: ExpressibleByArrayLitteral
    typealias ArrayLiteralElement = Double
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        self.storage = SIMD2<Double>(elements)
    }
}