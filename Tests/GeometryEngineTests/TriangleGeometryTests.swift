import XCTest
@testable import GeometryEngine

final class TriangleTests: XCTestCase {
    func testCollision() {
        
        let t1: Triangle = [[0, 0], [0, 3], [3, 0]]
        let t2: Triangle = [[-1, 4], [1, 4], [-1, 1]]
        let t3: Triangle = [[2, 2], [3, 1], [0, 1]]
        let t4: Triangle = [[0, -3], [-3, 5], [7, 3]]

        let p1: Vector2D = [-1, 1]
        let p2: Vector2D = [0, 1]
        let p3: Vector2D = [1, 1]
        let p4: Vector2D = [2, 1]
        let p5: Vector2D = [3, 1]

        // Points test
        XCTAssertTrue(t1.vertices.count == 3)
        
        // Contains tests
        XCTAssertFalse(t1.contains(p1))
        XCTAssertTrue(t1.contains(p2))
        XCTAssertTrue(t1.contains(p3))
        XCTAssertTrue(t1.contains(p4))
        XCTAssertFalse(t1.contains(p5))
        
            print(t1.intersection(with: t2))
        XCTAssertTrue(t1.intersection(with: t2).count == 2)
            print(t2.intersection(with: t1))
        XCTAssertTrue(t2.intersection(with: t1).count == 2)
        XCTAssertEqual(t1.collision(with: t2).count, 3)
        
        // Since two sides compose a corner, there is one more collision detected.
        print(t1.intersection(with: t3))
        XCTAssertTrue(t1.intersection(with: t3).count == 4)
        
        
        XCTAssertEqual(t1.collision(with: t4).count, 3)
        print(t4.collision(with: t1))

        // We confirm the working of GeometryPrimitive.count
        XCTAssertEqual(t1.vertices.count, 3)
        XCTAssertEqual(t1.getProjectionLines(direction: [1.0, 1.0]).count, 3);
    }
    
    static var allTests = [
        ("TriangleCollision", testCollision)
    ]
}
