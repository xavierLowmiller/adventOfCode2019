import XCTest
@testable import Day17

final class Day17Tests: XCTestCase {

	func testDay17SolutionPart1() {
		let robot = Robot(memory: input)
		print("Solution to day 17 part 1:", robot.imageChecksum)
		print(robot.image)
	}

	func testDay17SolutionPart2() {
		print("Solution to day 17 part 2:")
	}
}
