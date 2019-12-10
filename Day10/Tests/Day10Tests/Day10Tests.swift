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

	func testAngleBetweenVectors1() {
		// Given
		let v1 = Vector(dx: 0, dy: -1)
		let v2 = Vector(dx: 1, dy: 0)

		// When
		let angle = v1.angle(to: v2)

		// Then
		XCTAssertEqual(angle, .pi / 2)
	}

	func testAngleBetweenVectors2() {
		// Given
		let v1 = Vector(dx: 0, dy: -1)
		let v2 = Vector(dx: -1, dy: 0)

		// When
		let angle = v1.angle(to: v2)

		// Then
		XCTAssertEqual(angle, 3 * .pi / 2)
	}

	func testAngleBetweenVectors3() {
		// Given
		let v1 = Vector(dx: 0, dy: -1)
		let v2 = Vector(dx: 1, dy: -1)

		// When
		let angle = v1.angle(to: v2)

		// Then
		XCTAssertEqual(angle, .pi / 4, accuracy: 0.0000000001)
	}

	func testAngleBetweenVectors4() {
		// Given
		let v1 = Vector(dx: 0, dy: -1)
		let v2 = Vector(dx: 0, dy: 1)

		// When
		let angle = v1.angle(to: v2)

		// Then
		XCTAssertEqual(angle, .pi)
	}

	func testAngleBetweenVectors5() {
		// Given
		let v1 = Vector(dx: 0, dy: -1)
		let v2 = Vector(dx: -1, dy: -1)

		// When
		let angle = v1.angle(to: v2)

		// Then
		XCTAssertEqual(angle, .pi * 7 / 4)
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

	func testPart2Example1() {
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
		let asteroidsVaporized = map.vaporize(from: Point(x: 11, y: 13))

		// Then
		XCTAssertEqual(asteroidsVaporized[199], Point(x: 8, y: 2))
	}


	func testPart2Example2() {
		// Given
		let input = """
		.#....#####...#..
		##...##.#####..##
		##...#...#.#####.
		..#.....X...###..
		..#.#.....#....##
		"""
		let expected = [
			(8, 1),
			(9, 0),
			(9, 1),
			(10, 0),
			(9, 2),
			(11, 1),
			(12, 1),
			(11, 2),
			(15, 1),

			(12, 2),
			(13, 2),
			(14, 2),
			(15, 2),
			(12, 3),
			(16, 4),
			(15, 4),
			(10, 4),
			(4, 4),
		].map(Point.init)

		// When
		let map = AsteroidMap(input: input)
		let asteroidsVaporized = map.vaporize(from: Point(x: 8, y: 3))

		// Then
		for (vaporized, expectedAsteroid) in zip(asteroidsVaporized.prefix(18), ArraySlice(expected)) {
			XCTAssertEqual(vaporized, expectedAsteroid)
		}
	}

	func testDay10Part1() {
		let map = AsteroidMap(input: input)
		print("Solution to day 10 part 1:", map.bestAsteroid.1)
	}

	func testDay10Part2() {
		let map = AsteroidMap(input: input)
		let base = map.bestAsteroid.0
		let asteroid = map.vaporize(from: base)[199]
		print("Solution to day 10 part 2:", asteroid.x * 100 + asteroid.y)
	}
}

