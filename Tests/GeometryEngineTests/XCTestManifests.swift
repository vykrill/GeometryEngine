import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
         testCase(Vector2DTests.allTests),
         testCase(CommonTests.allTests),
         testCase(LineTests.allTests),
         testCase(AngleTests.allTests),
         testCase(TriangleTests.allTests)
    ]
}
#endif
