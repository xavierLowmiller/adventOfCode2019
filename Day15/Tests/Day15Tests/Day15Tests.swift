import XCTest
@testable import Day15

final class Day15Tests: XCTestCase {

	func testDay15SolutionPart1() {
		let robot = Robot(memory: input)
		print("Solution to day 15 part 1:", robot.findShortestPathToOxygen())
	}
}
