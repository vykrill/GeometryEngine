import XCTest
@testable import GeometryEngine

final class TriangleTests: XCTestCase {
    func initTest() {
        let tri1: Triangle = [[0, 0], [0, 1], [1, 0]]
    }

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

        // Contains tests
        XCTAssertFalse(t1.contains(p1))
        XCTAssertTrue(t1.contains(p2)) // failed
        XCTAssertTrue(t1.contains(p3))
        XCTAssertTrue(t1.contains(p4))
        XCTAssertFalse(t1.contains(p5)) // failed
    }
    
    static var allTests = [
        ("TriangleInit", initTest),
        ("TriangleCollision", testCollision)
    ]
}
