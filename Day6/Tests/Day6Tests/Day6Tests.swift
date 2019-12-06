import XCTest
@testable import Day6

final class Day6Tests: XCTestCase {
	func testExample() {
		// Given
		let input = """
		COM)B
		B)C
		C)D
		D)E
		E)F
		B)G
		G)H
		D)I
		E)J
		J)K
		K)L
		"""

		// When
		let orbit = Orbit(input: input)

		// Then
		XCTAssertEqual(orbit.checksum, 42)
	}

	func testDay6Part1() {
		let orbit = Orbit(input: input)
		print("Solution to day 6 part 1:", orbit.checksum)
	}
}
