import XCTest
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
			let program = IntCode(input: example.input)
			program.execute()

			// Then
			XCTAssertEqual(program.input, example.finalState)
		}
	}

	func testDay2Part1() {
		var copy = input
		copy[1] = 12
		copy[2] = 02
		let program = IntCode(input: copy)
		program.execute()
		print(program.output)
	}

	func testDay2Part2() {
		var copy = input
		for noun in 0...99 {
			for verb in 0...99 {
				copy[1] = noun
				copy[2] = verb
				let program = IntCode(input: copy)
				program.execute()

				if program.output == 19690720 {
					return print(100 * noun + verb)
				}
			}
		}

		XCTFail("Program didn't finish correctly")
	}
}
