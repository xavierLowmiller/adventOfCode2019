import Foundation

struct Point: Hashable, CustomStringConvertible {
	let x: Int
	let y: Int

	static let zero = Point(x: 0, y: 0)

	var description: String {
		"(\(x), \(y))"
	}

	func vector(to point: Point) -> Vector {
		Vector(dx: point.x - x, dy: point.y - y)
	}

	func vectors(to points: [Point]) -> [Vector] {
		points
			.filter { $0 != self }
			.map { vector(to: $0) }
	}
}

struct Vector: Hashable {
	let dx: Int
	let dy: Int

	var length: Double {
		sqrt(Double(dx * dx + dy * dy))
	}

	var direction: Vector {

		if dx == 0, dy == 0 {
			return Vector(dx: 0, dy: 0)
		}

		if dx == 0 {
			return Vector(dx: 0, dy: dy > 0 ? 1 : -1)
		}
		if dy == 0 {
			return Vector(dx: dx > 0 ? 1 : -1, dy: dy)
		}

		var copy = self
		for candidate in [2, 3, 5, 7, 11, 13] {
			while copy.dx.isMultiple(of: candidate) && copy.dy.isMultiple(of: candidate) {
				copy = Vector(dx: copy.dx / candidate, dy: copy.dy / candidate)
			}
		}

		return copy
	}

	func isCodirectional(to vector: Vector) -> Bool {
		self.direction == vector.direction
	}

	func angle(to vector: Vector) -> Double {
		let dotProduct = dx * vector.dx + dy * vector.dy
		let lengths = length * vector.length

		let angle = acos(Double(dotProduct) / lengths)

		if vector.dx < 0 {
			return 2 * .pi - angle
		} else {
			return angle
		}
	}
}

struct AsteroidMap {
	let asteroids: [Point]

	init(input: String) {
		asteroids = input.split(separator: "\n").enumerated()
			.reduce(into: []) {
				let (y, line) = $1
				for (x, c) in line.enumerated() where c == "#" {
					$0.append(Point(x: x, y: y))
				}
		}
	}

	var bestAsteroid: (Point, Int) {
		var bestAsteroid = (point: Point.zero, amount: 0)

		for asteroid in asteroids {
			let vectors = Set(asteroid
				.vectors(to: asteroids)
				.map { $0.direction })

			if bestAsteroid.amount < vectors.count {
				bestAsteroid = (asteroid, vectors.count)
			}
		}

		return bestAsteroid
	}

	func vaporize(from asteroid: Point) -> [Point] {
		let asteroidsToVaporize = asteroids.filter { $0 != asteroid }

		// A mapping from direction to points
		var byAngle: [Vector: [Point]] = Dictionary(grouping: asteroidsToVaporize) {
			let vector = asteroid.vector(to: $0)
			return vector.direction
		}
		.mapValues { value in
			value.sorted { asteroid.vector(to: $0).length < asteroid.vector(to: $1).length }
		}

		let initialVector = Vector(dx: 0, dy: -1)

		var pointsInOrder: [Point] = []

		while !byAngle.isEmpty {
			let sortedKeys = byAngle.keys.sorted {
				initialVector.angle(to: $0) < initialVector.angle(to: $1)
			}
			for angle in sortedKeys {
				let point = byAngle[angle]!.removeFirst()
				pointsInOrder.append(point)
				if byAngle[angle]!.isEmpty {
					byAngle[angle] = nil
				}
			}
		}

		assert(pointsInOrder.count == asteroidsToVaporize.count)

		return pointsInOrder
	}
}
