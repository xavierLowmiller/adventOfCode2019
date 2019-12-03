import XCTest
@testable import Day3

final class Day3Tests: XCTestCase {
	func testExampleIntersections1Part1() {
		// Given
		let input = """
		R75,D30,R83,U83,L12,D49,R71,U7,L72
		U62,R66,U55,R34,D71,R55,D58,R83
		"""

		// When
		let minimumIntersection = findClosestIntersection(of: input)

		// Then
		XCTAssertEqual(minimumIntersection, 159)
	}

	func testExampleIntersections2Part1() {
		// Given
		let input = """
		R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
		U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
		"""

		// When
		let minimumIntersection = findClosestIntersection(of: input)

		// Then
		XCTAssertEqual(minimumIntersection, 135)
	}

	func testExampleIntersections3Part1() {
		// Given
		let input = """
		R8,U5,L5,D3
		U7,R6,D4,L4
		"""

		// When
		let minimumIntersection = findClosestIntersection(of: input)

		// Then
		XCTAssertEqual(minimumIntersection, 6)
	}

	func testDay3SolutionPart1() {
		print("Solution to day 3 part 1:", findClosestIntersection(of: input))
	}

	func testExampleIntersections1Part2() {
		// Given
		let input = """
		R75,D30,R83,U83,L12,D49,R71,U7,L72
		U62,R66,U55,R34,D71,R55,D58,R83
		"""

		// When
		let minimumSignalDelay = signalDelay(of: input)

		// Then
		XCTAssertEqual(minimumSignalDelay, 610)
	}

	func testExampleIntersections2Part2() {
		// Given
		let input = """
		R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
		U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
		"""

		// When
		let minimumSignalDelay = signalDelay(of: input)

		// Then
		XCTAssertEqual(minimumSignalDelay, 410)
	}

	func testExampleIntersections3Part2() {
		// Given
		let input = """
		R8,U5,L5,D3
		U7,R6,D4,L4
		"""

		// When
		let minimumSignalDelay = signalDelay(of: input)

		// Then
		XCTAssertEqual(minimumSignalDelay, 30)
	}

	func testDay3SolutionPart2() {
		print("Solution to day 3 part 2:", signalDelay(of: input))
	}
}
