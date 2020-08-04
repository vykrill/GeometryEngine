// GeometryPrimitiveProtocol.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 7th, 2020
//

/// A component of a shape.
protocol GeometryPrimitive {
    func isPointInward(_: Vector2D, clockwise: Bool) -> Bool
    var points: [Vector2D] { get }
}
