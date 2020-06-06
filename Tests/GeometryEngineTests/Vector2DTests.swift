import XCTest
@testable import GeometryEngine

final class Vector2DTests: XCTestCase {
    func testInits() {
        // init from array litteral
        let vect1: Vector2D = [ 1, 1]
        XCTAssertEqual(vect1.x, 1)
        XCTAssertEqual(vect1.y, 1)
    }

    static var allTests = [
        ("testInits", testInits),
    ]
}
