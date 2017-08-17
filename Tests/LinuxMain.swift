import XCTest
@testable import SwiftRandomTests

typealias TestClosure = () throws -> Void
typealias UnitTestClosure<T> = (T) -> TestClosure
typealias UnitTest<T> = (String, UnitTestClosure<T>)

extension SwiftRandomTests {
	static var allTests: [UnitTest<SwiftRandomTests>] {
		return [
			("testStaticMethods", testStaticMethods),
			("testTypeExtensions", testTypeExtensions),
			("testListItemRandom", testListItemRandom),
			("testRandomIntRange", testRandomIntRange),
			("testRandomStringOfLength", testRandomStringOfLength),
			("testRandomStringOfVariableLength", testRandomStringOfVariableLength),
			("testRandomStringWithPossibleCharacters", testRandomStringWithPossibleCharacters)
		]
	}
}

XCTMain([
    testCase(SwiftRandomTests.allTests),
])
