import XCTest
@testable import Day13

final class Day13Tests: XCTestCase {

	func testDay13Part1() {
		let game = Game(memory: input)
		game.drawDefaultBoard()
		let blocks = game.tiles.filter { $0.kind == .block }

		print("Solution to day 13 part 1:", blocks.count)
	}

	func testDay13Part2() {
		var memory = input
		memory[0] = 2
		let game = Game(memory: memory)

		print("Solution to day 13 part 2:", game.play())
	}
}
