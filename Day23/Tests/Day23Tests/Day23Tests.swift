import XCTest
@testable import Day23

final class Day23Tests: XCTestCase {

	func testDay23SolutionPart1() {
		let network = Network(memory: input)
		print("Solution to day 23 part 1:", network.run().Y)
	}

	func testDay23SolutionPart2() {
		print("Solution to day 23 part 2:")
	}
}
