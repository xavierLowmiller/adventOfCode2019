import XCTest
@testable import IntCode

final class IntCodeTests: XCTestCase {

	func testDay2Tests() {
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

	func testDay5Tests() {
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

	func testRelativeBase() {
		// Given
		let input = [109, 1, 204, 0, 99]

		// When
		let computer = Computer(memory: input)
		let output = computer.execute()

		// Then
		XCTAssertEqual(output, 1)
	}
}
