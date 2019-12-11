import XCTest
@testable import Day11

final class Day11Tests: XCTestCase {
	func testDay11Part1() {
		let robot = Robot(memory: input, baseColor: 0)
		robot.paint()

		print("Solution to day 11 part 1:", robot.positions.count)
	}

	func testDay11Part2() {
		let robot = Robot(memory: input, baseColor: 1)
		robot.paint()

		print("Solution to day 11 part 2:")
		print(robot.painting)
	}
}
