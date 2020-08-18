// CollisionTestResult.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 7th, 2020
//

enum CollisionTestResult: Equatable, Hashable {

    /// There is no collision.
    case none
    /// There is a contact point.
    case point(position: Vector2D)
    /// Two lines overlap each other.
    case segment(section: Line)
}