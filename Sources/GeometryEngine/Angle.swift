// Angle.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 5th, 2020
//

/// A property wrapper for angles.
@propertyWrapper
struct Angle {

    private var value: Double

    var wrappedValue: Double {
        get { value }
        set { 
            value = newValue
            bounds(&value)
         }
    }

    /// Bounds the specified angle to a value between `0` and `2π`.
    /// - parameters:
    ///     - angle: The angle to bounds.
    private func bounds(_ angle: inout Double) {
        while angle < 0 {
            angle += 2 * π
        }
        while angle > 2 * π {
            angle -= 2 * π
        }
    }
}