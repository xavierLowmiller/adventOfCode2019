import XCTest
@testable import Day12

final class AlgorithmTests: XCTestCase {

	func testLCM() {
		// Given
		let examples: [([Int], Int?)] = [
			([], nil),
			([1], 1),
			([4, 6], 12),
			([4, 6, 8], 24)
		]

		for (array, expected) in examples {
			// When
			let lcm = array.lcm

			// Then
			XCTAssertEqual(lcm, expected)
		}
	}
}
