import XCTest
@testable import Day19

final class Day19Tests: XCTestCase {

	func testDay19SolutionPart1() {
		let tractorBeam = TractorBeam(memory: input)
		print("Solution to day 19 part 1:",
					tractorBeam.pointsAffectedByTractorBeam(in: 50)
						.flatMap { $0 }
						.filter { $0 == 1 }.count)
	}

	func testDay19SolutionPart2() {
		let tractorBeam = TractorBeam(memory: input)
		let coordinate = tractorBeam.coordinateOfFirst100By100Square
		print("Solution to day 19 part 2:", coordinate.x * 10000 + coordinate.y)
	}
}
