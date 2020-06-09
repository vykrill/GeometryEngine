import XCTest
@testable import GeometryEngine

final class CommonTests: XCTestCase {
    func testApproximatelyEqual() {
        XCTAssertEqual(0.1234567890.rounded(toPlace: 4), 0.1235)
        XCTAssertTrue(0.1234567 ~= 0.12345678)
        // For a change in precision, best practice is to change it an then revert it to the default value.
        Double.equalityPrecision = 3
        XCTAssertTrue(0.125 ~= 0.12489621)
        Double.equalityPrecision = Double.defaultEqualityPrecision
    }

    static var allTests = [
        ("testApproximatelyEqual", testApproximatelyEqual)
    ]
}
