import XCTest
@testable import Day4

final class Day4Tests: XCTestCase {
	func testContainsNumberMoreThanTwicePositive() {
		// Given
		let examples = [
			111234,
			123444,
			123345
		].map(String.init)

		for example in examples {
			// When
			let containsDuplicate = example.containsDuplicate

			// Then
			XCTAssert(containsDuplicate)
		}
	}

	func testContainsNumberMoreThanTwiceNegative() {
		// Given
		let examples = [
			123456,
			654321,
			152369
		].map(String.init)

		for example in examples {
			// When
			let containsDuplicate = example.containsDuplicate

			// Then
			XCTAssertFalse(containsDuplicate)
		}
	}

	func testContainsNumberExactlyTwicePositive() {
		// Given
		let examples = [
			112345,
			114444,
			445678
		].map(String.init)

		for example in examples {
			// When
			let containsExactDuplicate = example.containsExactDuplicate

			// Then
			XCTAssert(containsExactDuplicate)
		}
	}

	func testContainsNumberExactlyTwiceNegative() {
		// Given
		let examples = [
			111444,
			111234,
			123456
		].map(String.init)

		for example in examples {
			// When
			let containsExactDuplicate = example.containsExactDuplicate

			// Then
			XCTAssertFalse(containsExactDuplicate)
		}
	}

	func testIsAscendingPositive() {
		// Given
		let examples = [
			111444,
			111234,
			123456,
			111111
		].map(String.init)

		for example in examples {
			// When
			let isOnlyAscending = example.isOnlyAscending

			// Then
			XCTAssert(isOnlyAscending)
		}
	}

	func testIsAscendingNegative() {
		// Given
		let examples = [
			411144,
			912345,
			654321,
			111110
		].map(String.init)

		for example in examples {
			// When
			let isOnlyAscending = example.isOnlyAscending

			// Then
			XCTAssertFalse(isOnlyAscending)
		}
	}

	func testDay4SolutionPart1() {
		print("Solution to day 4 part 1:", possiblePasswordsPart1())
	}

	func testDay4SolutionPart2() {
		print("Solution to day 4 part 2:", possiblePasswordsPart2())
	}
}
