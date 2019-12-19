import XCTest
@testable import Day19

final class Day19Tests: XCTestCase {

	func testDay19SolutionPart1() {
		let tractorBeam = TractorBeam(memory: input)
		print("Solution to day 19 part 1:",
					tractorBeam.pointsAffectedByTractorBeam(in: 50)
						.filter { $0.value == 1 }.count)
	}

	func testDay19SolutionPart2() {
		print("Solution to day 19 part 2:")
	}
}
