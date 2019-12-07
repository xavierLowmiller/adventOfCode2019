import XCTest
@testable import Day7

final class Day7Tests: XCTestCase {
	func testExamplesDay7Part1() {
		// Given
		let examples: [(config: [Int], input: [Int], maxValue: Int)] = [
			([4, 3, 2, 1, 0], [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0], 43210),
			([0, 1, 2, 3, 4], [3,23,3,24,1002,24,10,24,1002,23,-1,23,
												 101,5,23,23,1,24,23,23,4,23,99,0,0], 54321),
			([1, 0, 4, 3, 2], [3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,
												 1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0], 65210),
		]

		for example in examples {
			// When
			let assembly = IntCodeAssembly(
				memory: example.input,
				phaseSettings: example.config
			)

			// Then
			XCTAssertEqual(assembly.execute(), example.maxValue)
		}
	}


	func testDay7Part1() {
		print("Solution to day 5 part 1:", IntCodeAssembly.findMaxOutput())
	}
}
