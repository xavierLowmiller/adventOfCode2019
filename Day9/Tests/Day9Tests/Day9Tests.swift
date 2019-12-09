import XCTest
import IntCode
@testable import Day9

final class Day9Tests: XCTestCase {
	func testDay9Part1() {
		let computer = Computer(memory: input)
		print("Solution to day 9 part 1:", computer.execute(input: 1) ?? -1)
	}

	func testDay9Part2() {
		let computer = Computer(memory: input)
		print("Solution to day 9 part 2:", computer.execute(input: 2) ?? -1)
	}
}
