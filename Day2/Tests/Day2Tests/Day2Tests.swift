import XCTest
import IntCode
@testable import Day2

final class Day2Tests: XCTestCase {

	func testIntCodeExecution() {
		// Given
		let examples: [(input: [Int], finalState: [Int])] = [
			([1, 0, 0, 0, 99],  [2, 0, 0, 0, 99]),
			([2, 3, 0, 3, 99],  [2, 3, 0, 6, 99]),
			([2, 4, 4, 5, 99, 0],  [2, 4, 4, 5, 99, 9801]),
			([1, 1, 1, 4, 99, 5, 6, 0, 99],  [30, 1, 1, 4, 2, 5, 6, 0, 99]),
		]

		for example in examples {
			// When
			let program = Computer(memory: example.input)
			program.execute()

			// Then
			XCTAssertEqual(program.memory, example.finalState)
		}
	}

	func testDay2Part1() {
		var copy = input
		copy[1] = 12
		copy[2] = 02
		let program = Computer(memory: copy)
		program.execute()
		print("Solution to day 2 part 1:", program.memory[0])
	}

	func testDay2Part2() {
		var copy = input
		for noun in 0...99 {
			for verb in 0...99 {
				copy[1] = noun
				copy[2] = verb
				let program = Computer(memory: copy)
				program.execute()

				if program.memory[0] == 19690720 {
					return print("Solution to day 2 part 2:", 100 * noun + verb)
				}
			}
		}

		XCTFail("Program didn't finish correctly")
	}
}
