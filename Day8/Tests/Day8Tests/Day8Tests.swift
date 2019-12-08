import XCTest
@testable import Day8

final class Day8Tests: XCTestCase {
	func testExampleDay8Part1() {
		// Given
		let input = "123456789012"
		let image = Image(input: input, width: 3, height: 2)

		// When
		let checksum = image.checksum

		// Then
		XCTAssertEqual(checksum, 1)
	}

	func testExampleDay8Part2() {
		// Given
		let input = "0222112222120000"
		let image = Image(input: input, width: 2, height: 2)

		// When
		let decoded = image.decoded

		// Then
		XCTAssertEqual(decoded, ["01", "10"])
	}

	func testDay8Part1() {
		let image = Image(input: input, width: 25, height: 6)
		print("Solution to day 8 part 1:", image.checksum)
	}

	func testDay8Part2() {
		let image = Image(input: input, width: 25, height: 6)
		print("Solution to day 8 part 2:")
		print(image.decoded.pretty)
	}
}

private extension Array where Element == String {
	var pretty: String {
		reduce("") { $0 + $1 + "\n" }
			.replacingOccurrences(of: "0", with: " ")
	}
}
