import XCTest
@testable import Day1

final class Day1Tests: XCTestCase {
	func testExampleMasses() {
		// Given
		let examples: [(input: Int, expected: Int)] = [
			(12, 2),
			(14, 2),
			(1969, 654),
			(100756, 33583)
		]

		for example in examples {
			// When
			let fuelRequired = calculateFuel(for: example.input)
			
			// Then
			XCTAssertEqual(fuelRequired, example.expected)
		}
	}
	
	func testExampleMassesIncludingFuelsFuel() {
		// Given
		let examples: [(input: Int, expected: Int)] = [
			(12, 2),
			(14, 2),
			(1969, 966),
			(100756, 50346)
		]
		
		for example in examples {
			// When
			let fuelRequired = calculateFuelIncludingFuelsFuel(for: example.input)
			
			// Then
			XCTAssertEqual(fuelRequired, example.expected)
		}
	}

	func testDay1Part1() {
		print("Solution to day 1 part 1:", input
			.map(calculateFuel)
			.reduce(0, +))
	}

	func testDay1Part2() {
		print("Solution to day 1 part 2:", input
			.map(calculateFuelIncludingFuelsFuel)
			.reduce(0, +))
	}
}
