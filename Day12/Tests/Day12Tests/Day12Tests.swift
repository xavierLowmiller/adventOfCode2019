import XCTest
@testable import Day12

final class Day12Tests: XCTestCase {
	func testArrayPairs1() {
		// Given
		let array = [1, 2, 3]
		let expected = [(1, 2), (1, 3), (2, 3)]

		// When
		let pairs = array.allPairs

		// Then
		XCTAssertEqual(expected.count, pairs.count)
		for (expectedPair, pair) in zip(expected, pairs) {
			XCTAssertEqual(expectedPair.0, pair.0)
			XCTAssertEqual(expectedPair.1, pair.1)
		}
	}

	func testArrayPairs2() {
		// Given
		let array = [1, 2, 3, 4]
		let expected = [(1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)]

		// When
		let pairs = array.allPairs

		// Then
		XCTAssertEqual(expected.count, pairs.count)
		for (expectedPair, pair) in zip(expected, pairs) {
			XCTAssertEqual(expectedPair.0, pair.0)
			XCTAssertEqual(expectedPair.1, pair.1)
		}
	}

	func testUpdateVelocity() {
		// Given
		let system = System(moons: [
			.init(positionT: (-1, 0, 2)),
			.init(positionT: (2, -10, -7)),
			.init(positionT: (4,-8, 8)),
			.init(positionT: (3, 5, -1))
		])


		let expected = System(moons:[
			.init(positionT: (-1, 0, 2), velocityT: (3, -1, -1)),
			.init(positionT: (2, -10, -7), velocityT: (1, 3, 3)),
			.init(positionT: (4,-8, 8), velocityT: (-3, 1, -3)),
			.init(positionT: (3, 5, -1), velocityT: (-1, -3, 1))
		])

		// When
		system.updateVelocities()

		// Then
		XCTAssertEqual(system.moons, expected.moons)
	}

	func testUpdatePositions() {
		// Given
		let system = System(moons: [
			.init(positionT: (2, -1, 1), velocityT: (3, -1, -1)),
			.init(positionT: (3, -7, -4), velocityT: (1, 3, 3)),
			.init(positionT: (1, -7, 5), velocityT: (-3, 1, -3)),
			.init(positionT: (2, 2, 0), velocityT: (-1, -3, 1))
		])
		let expected = System(moons:[
			.init(positionT: (5, -2, 0), velocityT: (3, -1, -1)),
			.init(positionT: (4, -4, -1), velocityT: (1, 3, 3)),
			.init(positionT: (-2, -6, 2), velocityT: (-3, 1, -3)),
			.init(positionT: (1, -1, 1), velocityT: (-1, -3, 1))
		])

		// When
		system.updatePositions()

		// Then
		XCTAssertEqual(system.moons, expected.moons)
	}

	func testSystemSteps1() {
		// Given
		let system = System(moons: [
			.init(positionT: (-1, 0, 2)),
			.init(positionT: (2, -10, -7)),
			.init(positionT: (4, -8, 8)),
			.init(positionT: (3, 5, -1))
		])
		let expected = System(moons:[
			.init(positionT: (2, -1, 1), velocityT: (3, -1, -1)),
			.init(positionT: (3, -7, -4), velocityT: (1, 3, 3)),
			.init(positionT: (1, -7, 5), velocityT: (-3, 1, -3)),
			.init(positionT: (2, 2, 0), velocityT: (-1, -3, 1))
		])

		// When
		system.step()

		// Then
		XCTAssertEqual(system.moons, expected.moons)
	}

	func testSystemSteps10() {
		// Given
		let system = System(moons: [
			.init(positionT: (-1, 0, 2)),
			.init(positionT: (2, -10, -7)),
			.init(positionT: (4, -8, 8)),
			.init(positionT: (3, 5, -1))
		])
		let expected = System(moons:[
			.init(positionT: (2,  1, -3), velocityT: (-3, -2,  1)),
			.init(positionT: (1, -8,  0), velocityT: (-1,  1,  3)),
			.init(positionT: (3, -6,  1), velocityT: ( 3,  2, -3)),
			.init(positionT: (2,  0,  4), velocityT: ( 1, -1, -1))
		])

		// When
		for _ in 0..<10 {
			system.step()
		}

		// Then
		XCTAssertEqual(system.moons, expected.moons)
		XCTAssertEqual(system.energy, 179)
	}

	func testDay12Part1() {
		let system = input

		for _ in 0..<1000 {
			system.step()
		}

		print("Solution to day 12 part 1:", system.energy)
	}

	func testDay12Part2() {
		print("Solution to day 12 part 2:")
	}
}
