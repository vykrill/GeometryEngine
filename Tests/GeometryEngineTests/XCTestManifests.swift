import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
         testCase(Vector2DTests.allTests)
    ]
}
#endif
