import XCTest
@testable import Day10

final class Day10Tests: XCTestCase {

	func testVectorDirection() {
		// Given
		let v1 = Vector(dx: 3, dy: 6)
		let v2 = Vector(dx: 2, dy: 4)
		let v3 = Vector(dx: 2, dy: 3)

		// Then
		XCTAssert(v1.isCodirectional(to: v2))
		XCTAssert(v2.isCodirectional(to: v1))

		XCTAssertFalse(v1.isCodirectional(to: v3))
		XCTAssertFalse(v3.isCodirectional(to: v1))

		XCTAssertFalse(v2.isCodirectional(to: v3))
		XCTAssertFalse(v3.isCodirectional(to: v2))
	}

	func testVectorLength() {
		// Given
		let v1 = Vector(dx: 1, dy: 2)
		let v2 = Vector(dx: 2, dy: 4)
		let v3 = Vector(dx: 2, dy: 3)

		// Then
		XCTAssert(v1.length < v2.length)
		XCTAssert(v1.length < v3.length)
		XCTAssert(v3.length < v2.length)
	}

	func testVectorIsBlocked() {
		// Given
		let v1 = Vector(dx: 3, dy: 6)
		let v2 = Vector(dx: 2, dy: 4)
		let v3 = Vector(dx: 2, dy: 3)

		// Then
		XCTAssert(v1.isBlocked(by: v2))
		XCTAssertFalse(v2.isBlocked(by: v1))

		XCTAssertFalse(v1.isBlocked(by: v3))
		XCTAssertFalse(v3.isBlocked(by: v1))

		XCTAssertFalse(v2.isBlocked(by: v3))
		XCTAssertFalse(v3.isBlocked(by: v2))
	}

	func testPart1Example1() {
		// Given
		let input = """
		.#..#
		.....
		#####
		....#
		...##
		"""

		// When
		let map = AsteroidMap(input: input)
		let (point, amount) = map.bestAsteroid

		// Then
		XCTAssertEqual(point, Point(x: 3, y: 4))
		XCTAssertEqual(amount, 8)
	}

	func testPart1Example2() {
		// Given
		let input = """
		......#.#.
		#..#.#....
		..#######.
		.#.#.###..
		.#..#.....
		..#....#.#
		#..#....#.
		.##.#..###
		##...#..#.
		.#....####
		"""

		// When
		let map = AsteroidMap(input: input)
		let (point, amount) = map.bestAsteroid

		// Then
		XCTAssertEqual(point, Point(x: 5, y: 8))
		XCTAssertEqual(amount, 33)
	}

	func testPart1Example3() {
		// Given
		let input = """
		#.#...#.#.
		.###....#.
		.#....#...
		##.#.#.#.#
		....#.#.#.
		.##..###.#
		..#...##..
		..##....##
		......#...
		.####.###.
		"""

		// When
		let map = AsteroidMap(input: input)
		let (point, amount) = map.bestAsteroid

		// Then
		XCTAssertEqual(point, Point(x: 1, y: 2))
		XCTAssertEqual(amount, 35)
	}

	func testPart1Example4() {
		// Given
		let input = """
		.#..#..###
		####.###.#
		....###.#.
		..###.##.#
		##.##.#.#.
		....###..#
		..#.#..#.#
		#..#.#.###
		.##...##.#
		.....#.#..
		"""

		// When
		let map = AsteroidMap(input: input)
		let (point, amount) = map.bestAsteroid

		// Then
		XCTAssertEqual(point, Point(x: 6, y: 3))
		XCTAssertEqual(amount, 41)
	}

	func testPart1Example5() {
		// Given
		let input = """
		.#..##.###...#######
		##.############..##.
		.#.######.########.#
		.###.#######.####.#.
		#####.##.#.##.###.##
		..#####..#.#########
		####################
		#.####....###.#.#.##
		##.#################
		#####.##.###..####..
		..######..##.#######
		####.##.####...##..#
		.#####..#.######.###
		##...#.##########...
		#.##########.#######
		.####.#.###.###.#.##
		....##.##.###..#####
		.#.#.###########.###
		#.#.#.#####.####.###
		###.##.####.##.#..##
		"""

		// When
		let map = AsteroidMap(input: input)
		let (point, amount) = map.bestAsteroid

		// Then
		XCTAssertEqual(point, Point(x: 11, y: 13))
		XCTAssertEqual(amount, 210)
	}

	func testDay10Part1() {
		let map = AsteroidMap(input: input)
		print("Solution to day 10 part 1:", map.bestAsteroid.1)
	}
}

