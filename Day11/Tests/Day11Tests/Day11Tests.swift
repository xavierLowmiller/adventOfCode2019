import XCTest
@testable import Day11

final class Day11Tests: XCTestCase {
	func testDay11Part1() {
		let robot = Robot(memory: input)
		robot.paint()

		print("Solution to day 11 part 1:", robot.positionsVisited.count)
	}

	func testDay11Part2() {
		print("Solution to day 11 part 2:")
	}
}
