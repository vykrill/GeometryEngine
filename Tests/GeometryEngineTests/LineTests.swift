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

    static var allTests = [
        ("testInits", testInits),
        ("testComputed", testComputedProperties)
    ]
}
