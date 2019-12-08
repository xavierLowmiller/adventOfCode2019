import XCTest
import IntCode
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
			let program = Computer(memory: example.input)
			program.execute()

			// Then
			XCTAssertEqual(program.memory, example.finalState)
		}
	}

	func testDay5Part1() {
		let program = Computer(memory: input)
		var output = 0
		while let newOutput = program.execute(input: 1) {
			XCTAssertEqual(output, 0)
			output = newOutput
		}
		print("Solution to day 5 part 1:", output)
	}

	func testDay5Part2() throws {
		let program = Computer(memory: input)
		let output = try XCTUnwrap(program.execute(input: 5))
		print("Solution to day 5 part 2:", output)
	}
}
