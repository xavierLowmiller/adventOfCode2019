import XCTest
@testable import Day16

final class Day16Tests: XCTestCase {
	func testSinglePhaseStepExample1() {
		// Given
		let input = "12345678".intArray
		let expected = "48226158".intArray

		// When
		let output = fft(of: input, phases: 1)

		// Then
		XCTAssertEqual(output, expected)
	}

	func testSinglePhaseStepExample2() {
		// Given
		let input = "12345678".intArray
		let expected = "34040438".intArray

		// When
		let output = fft(of: input, phases: 2)

		// Then
		XCTAssertEqual(output, expected)
	}

	func testSinglePhaseStepExample3() {
		// Given
		let input = "12345678".intArray
		let expected = "03415518".intArray

		// When
		let output = fft(of: input, phases: 3)

		// Then
		XCTAssertEqual(output, expected)
	}

	func testSinglePhaseStepExample4() {
		// Given
		let input = "12345678".intArray
		let expected = "01029498".intArray

		// When
		let output = fft(of: input, phases: 4)

		// Then
		XCTAssertEqual(output, expected)
	}

	func testLongPhaseExamples1() {
		// Given
		let input = "80871224585914546619083218645595".intArray
		let expected = "24176176".intArray

		// When
		let output = fft(of: input, phases: 100)

		// Then
		XCTAssertEqual(output.prefix(8), expected.prefix(8))
	}

	func testLongPhaseExamples2() {
		// Given
		let input = "19617804207202209144916044189917".intArray
		let expected = "73745418".intArray

		// When
		let output = fft(of: input, phases: 100)

		// Then
		XCTAssertEqual(output.prefix(8), expected.prefix(8))
	}

	func testLongPhaseExamples3() {
		// Given
		let input = "69317163492948606335995924319873".intArray
		let expected = "52432133".intArray

		// When
		let output = fft(of: input, phases: 100)

		// Then
		XCTAssertEqual(output.prefix(8), expected.prefix(8))
	}

	func testDay16SolutionPart1() {
		let number = fft(of: input.intArray, phases: 100)
		print("Solution to day 16 part 1:", number.map { String($0) }.prefix(8).joined())
	}
}

extension String {
	var intArray: [Int] {
		compactMap { Int(String($0)) }
	}
}
