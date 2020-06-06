import XCTest
@testable import GeometryEngine

final class Vector2DTests: XCTestCase {
    func testInits() {
        // init from array litteral
        let vect1: Vector2D = [ 0.5, 0.5]
        XCTAssertEqual(vect1.x, 0.5)
        XCTAssertEqual(vect1.y, 0.5)

        // init with length and direction
        let vect2 = Vector2D(length: (sqrt(2) / 2), angle: Double.pi / 4)
        XCTAssertEqual(vect2, vect1)
    }

    static var allTests = [
        ("testInits", testInits)
    ]
}
