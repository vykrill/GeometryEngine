import XCTest
@testable import GeometryEngine

final class CommonTests: XCTestCase {
    func testApproximatelyEqual() {
        XCTAssertEqual(0.1234567890.rounded(toPlace: 4), 0.1235)
        
    }

    static var allTests = [
        ("testApproximatelyEqual", testApproximatelyEqual)
    ]
}
