import XCTest
@testable import Day13

final class Day13Tests: XCTestCase {


	func testDay13Part1() {
		let game = Game(memory: input)
		let blocks = game.tiles.filter { $0.kind == .block }

		print("Solution to day 13 part 1:", blocks.count)
	}

	func testDay13Part2() {

		print("Solution to day 13 part 2:")
	}
}
