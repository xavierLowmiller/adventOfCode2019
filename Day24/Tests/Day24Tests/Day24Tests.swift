import XCTest
@testable import Day24

final class Day24Tests: XCTestCase {
	func testExampleTick1() {
		// Given
		let input = """
			....#
			#..#.
			#..##
			..#..
			#....
			"""
		let expected = """
			#..#.
			####.
			###.#
			##.##
			.##..
			"""
		let board = Board(input: input)

		// When
		board.tick()

		// Then
		XCTAssertEqual(board.description, expected)
	}

	func testExampleTick2() {
		// Given
		let input = """
			#..#.
			####.
			###.#
			##.##
			.##..
			"""
		let expected = """
			#####
			....#
			....#
			...#.
			#.###
			"""
		let board = Board(input: input)

		// When
		board.tick()

		// Then
		XCTAssertEqual(board.description, expected)
	}

	func testExampleTick3() {
		// Given
		let input = """
			#####
			....#
			....#
			...#.
			#.###
			"""
		let expected = """
			#....
			####.
			...##
			#.##.
			.##.#
			"""
		let board = Board(input: input)

		// When
		board.tick()

		// Then
		XCTAssertEqual(board.description, expected)
	}

	func testExampleTick4() {
		// Given
		let input = """
			#....
			####.
			...##
			#.##.
			.##.#
			"""
		let expected = """
			####.
			....#
			##..#
			.....
			##...
			"""
		let board = Board(input: input)

		// When
		board.tick()

		// Then
		XCTAssertEqual(board.description, expected)
	}

	func testScore() {
		// Given
		let input = """
			.....
			.....
			.....
			#....
			.#...
			"""
		let expected = 2129920
		let board = Board(input: input)

		// When
		let score = board.score

		// Then
		XCTAssertEqual(score, expected)
	}

	func testExampleRepeatingConfig() {
		// Given
		let input = """
			....#
			#..#.
			#..##
			..#..
			#....
			"""
		let expected = 2129920
		let board = Board(input: input)

		// When
		let repeatingConfig = board.findRepeatingConfig()

		// Then
		XCTAssertEqual(repeatingConfig, expected)
	}

	func testDay24SolutionPart1() {
		let board = Board(input: input)
		print("Solution to day 24 part 1:", board.findRepeatingConfig())
	}

	func testDay24SolutionPart2() {
		print("Solution to day 24 part 2:")
	}
}
