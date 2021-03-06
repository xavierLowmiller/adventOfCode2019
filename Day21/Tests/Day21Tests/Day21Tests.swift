import XCTest
@testable import Day21

final class Day21Tests: XCTestCase {

	func testDay21SolutionPart1() {
		let springDroid = SpringDroid(memory: input)
		print("Solution to day 21 part 1:", springDroid.findHullDamageWalking())
	}

	func testDay21SolutionPart2() {
		let springDroid = SpringDroid(memory: input)
		print("Solution to day 21 part 2:", springDroid.findHullDamageRunning())
	}
}
