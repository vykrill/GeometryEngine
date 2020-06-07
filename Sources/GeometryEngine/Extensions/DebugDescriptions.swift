// DebugDescriptions.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 7th, 2020
//
// Contains Debug description for many GeometryEngine types.

extension Vector2D: CustomDebugStringConvertible {
    var debugDescription: String { "v(\(self.x), \(self.y))" }
}

extension Line: CustomDebugStringConvertible {
    var debugDescription: String { "l[\(p1), \(p2)]" }
}

extension CollisionTestResult: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .none:
            return "none"
        case .point(let pos):
            return "point: \(pos)"
        case .segment(let sect):
            return "segment: \(sect)"            
        }
    }
    
}