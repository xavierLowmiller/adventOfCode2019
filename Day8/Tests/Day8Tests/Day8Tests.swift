import XCTest
@testable import Day8

final class Day8Tests: XCTestCase {
	func testExampleDay8Part1() {
		// Given
		let input = "123456789012"

		// When
		let image = Image(input: input, width: 3, height: 2)

		// Then
		XCTAssertEqual(image.checksum, 1)
	}

	func testDay8Part1() {
		let image = Image(input: input, width: 25, height: 6)
		print("Solution to day 8 part 1:", image.checksum)
	}
}
