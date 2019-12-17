import XCTest
@testable import Day17

final class Day17Tests: XCTestCase {

	func testDay17SolutionPart1() {
		let robot = Robot(memory: input)
		print("Solution to day 17 part 1:", robot.imageChecksum)
	}

	func testDay17SolutionPart2() {
		var memory = input
		memory[0] = 2
		let robot = Robot(memory: memory)
		print("Solution to day 17 part 2:", robot.traverseScaffolding())
	}
}
