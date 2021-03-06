import XCTest
@testable import GeometryEngine

final class LineTests: XCTestCase {
    func testInits() {
        let l1 = Line([0, 0], [1, 1])
        print(l1)
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

    func testIntersections() {
        let none = CollisionTestResult.none

        let l1 = Line([3, 3], [4, 4])
        let l2 = Line([0, 0], [1, 1])
        let l3 = Line([0, 0], [10, 10])
        let l4 = Line([3.5, 3.5], [0, 0])
        let l5 = Line([-2, 2], [3, 2])
        let l6 = Line([0, 0], [3, 3])
        let l7 = Line([0, 2], [4, 0])

        // l1.intersect(l2)
        XCTAssertEqual(l1.intersection(with: l2), none)
        XCTAssertNotEqual(l1.intersection(with: l3), none)
        XCTAssertNotEqual(l1.intersection(with: l4), none)

        print(Line.getIntersection(between: l1, and: l6))

        XCTAssertNotEqual(l3.intersection(with: l5), none)
        XCTAssertEqual(l3.intersection(with: l5), CollisionTestResult.point(position: [2.0, 2.0]))
        XCTAssertNotEqual(l6.intersection(with: l7), none)
    
    }

    func testPointInward() {
        let line = Line([3, 3], [4, 4])
        //Clockwise tests
        XCTAssertTrue(line.isPointInward([0, 0]))
        XCTAssertTrue(line.isPointInward([1, 0]))
        XCTAssertFalse(line.isPointInward([3, 6]))
        XCTAssertTrue(line.isPointInward([6, 5]))

        // Counter-clockwise
        XCTAssertTrue(line.isPointInward([0, 0], clockwise: false))
        XCTAssertFalse(line.isPointInward([1, 0], clockwise: false))
        XCTAssertTrue(line.isPointInward([3, 6], clockwise: false))
        XCTAssertFalse(line.isPointInward([6, 5], clockwise: false))
    }

    static var allTests = [
        ("LineInits", testInits),
        ("LineComputed", testComputedProperties),
        ("LineContains", testContains),
        ("LineIntersections", testIntersections),
        ("LinePointInward", testPointInward)
    ]
}
