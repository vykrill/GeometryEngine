import XCTest
@testable import GeometryEngine

final class AngleTests: XCTestCase {
    func testRelativeAngle() {
        XCTAssertTrue(Angle.getRelativeAngle(of: Double.pi / 4 ) ~= (Double.pi / 4))
        XCTAssertTrue(Angle.getRelativeAngle(of: Double.pi * 7 / 4 ) ~= (-1 * Double.pi / 4))
    }

    func testAngleDifference() {
        let dif1 = Angle.getDifferenceBetween(0.0, and: Double.pi / 4)
        let dif2 = Angle.getDifferenceBetween(Double.pi / 4, and: 0.0)
        print(dif1)
        print(dif2)
    }

    static var allTests = [
        ("RelativeAngle", testRelativeAngle),
        ("Difference", testAngleDifference)
    ]
}
