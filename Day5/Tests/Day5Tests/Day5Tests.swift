import XCTest
@testable import Day5

final class Day5Tests: XCTestCase {

	func testIntCodeExecution() {
		// Given
		let examples: [(input: [Int], finalState: [Int])] = [
			([1101, 100, -1, 4, 0],  [1101, 100, -1, 4, 99]),
			([1002, 4, 3, 4, 33], [1002, 4, 3, 4, 99]),
		]

		for example in examples {
			// When
			let program = IntCode(memory: example.input)
			program.execute()

			// Then
			XCTAssertEqual(program.memory, example.finalState)
		}
	}

	func testDay5Part1() {
		let program = IntCode(memory: input, input: 1)
		print("Solution to day 2 part 1:")
		program.execute()
	}
}
