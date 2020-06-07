import XCTest
@testable import GeometryEngine

final class LineTests: XCTestCase {
    func testInits() {
        let l1 = Line([0, 0], [1, 1])
        
        XCTAssertEqual(l1.p1, [0, 0])
        XCTAssertEqual(l1.p2, [1, 1])
    }

    func testComputedProperties() {
        let l1 = Line([4, 10], [5, 4])

        XCTAssertEqual(l1.vector, [1, -6])
        XCTAssertEqual(l1.maxX, 5)
        XCTAssertEqual(l1.minX, 4)
        XCTAssertEqual(l1.maxY, 10)
        XCTAssertEqual(l1.minY, 4)
    }

    func testContains() {
        let l1 = Line([-1, 6], [3, 10])

        XCTAssertTrue(l1.contains([-1, 6])) // First point
        XCTAssertTrue(l1.contains([3, 10])) // Last point
        XCTAssertTrue(l1.contains([0, 7])) // middle point

        XCTAssertFalse(l1.contains([1, 1])) // Random point
        XCTAssertFalse(l1.contains([-2, 5])) // Before first point
        XCTAssertFalse(l1.contains([4, 11])) // After last point

    }

    static var allTests = [
        ("testInits", testInits),
        ("testComputed", testComputedProperties),
        ("testContains", testContains)
    ]
}
