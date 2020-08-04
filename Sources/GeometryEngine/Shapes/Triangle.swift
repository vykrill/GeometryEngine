// Triangle.swift
// Created by Jérémy Goyette
// For GeometryEngine
// August 3rd, 2020
//

/// A simple triangle.
struct Triangle: ExpressibleByArrayLiteral, Geometry {
    
    typealias ArrayLiteralElement = Vector2D

    init(arrayLiteral elements: ArrayLiteralElement...) {
        assert(elements.count == 3, "Triangle.init(arrayLitteral: ): 3 elements only can be given.")
        self.vertices = elements

        if Line(vertices[0], vertices[1]).isPointInward(vertices[2]) == false {
            print("WARNING: Triangle \(self) is counter-clockwise.")
        }
    }

    static var clockwise = true

    /// The vertices composing the triangle.
    /// - important: There must be only 3 vertices in the triangle. Doing otherwise will crash the
    ///                 program.
    var vertices: [Vector2D] {
        didSet {
            assert(vertices.count == 3, "Triangle \(self) must have 3 vertices only.")
        }
    }

    // MARK: Geometry protocol

    var primitives: [GeometryPrimitive] {
        return [ 
            Line(self.vertices[0], self.vertices[1]),
            Line(self.vertices[1], self.vertices[2]),
            Line(self.vertices[2], self.vertices[0])
        ]
    }

}
