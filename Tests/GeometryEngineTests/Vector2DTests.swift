import XCTest
@testable import GeometryEngine

final class Vector2DTests: XCTestCase {
    func testInits() {
        // init from array litteral
        let vect1: Vector2D = [ 0.5, 0.5]
        print(vect1)
        XCTAssertEqual(vect1.x, 0.5)
        XCTAssertEqual(vect1.y, 0.5)

        // init with length and direction
        let vect2 = Vector2D(length: (sqrt(2) / 2), angle: Double.pi / 4)
        // Should be equal de vect1
        XCTAssertEqual(vect2, vect1)

        // init from SIMD2<Double>
        let vect3 = Vector2D(from: SIMD2<Double>(0.5, 0.5))
        XCTAssertEqual(vect1, vect3)
    }

    func testArithmetic(){
        var vect1: Vector2D = [1, 2]
        var vect2: Vector2D = [4, 7]

        XCTAssertEqual(vect1 + vect2, Vector2D(arrayLiteral: 5, 9))
        XCTAssertEqual(vect1 - vect2, Vector2D(arrayLiteral: -3, -5))

        vect1 += vect2 // [5, 9]
        vect2 -= vect1 // [-1, -2]

        XCTAssertEqual(vect1, Vector2D(arrayLiteral: 5, 9))
        XCTAssertEqual(vect2, Vector2D(arrayLiteral: -1, -2))

    }

    static var allTests = [
        ("testInits", testInits),
        ("testArithmetic", testArithmetic)
    ]
}
