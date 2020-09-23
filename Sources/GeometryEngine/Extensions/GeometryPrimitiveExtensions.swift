// GeometryPrimitiveExtensions.swift
// Created by Jérémy Goyette
// For GeometryEngine
// June 7th, 2020
//

extension GeometryPrimitive {
    // MARK: - Intersections with lines.
    func intersection(with: Line) -> CollisionTestResult { .none }

    func createProjectionLines(direction: Vector2D) -> [Line] {
        var result = [Line]()
        
        for vertice in self.vertices {
            let newLine = Line.init(vertice, vertice + direction)
            result.append(newLine)
        }

        return result
    }
}