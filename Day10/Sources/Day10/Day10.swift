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

struct Vector {
	let dx: Int
	let dy: Int

	/// This isn't the real length, but compares accurately
	var length: Int {
		dx * dx + dy * dy
	}

	func isCodirectional(to vector: Vector) -> Bool {
		let dotProduct = dx * vector.dx + dy * vector.dy
		return dotProduct * dotProduct == length * vector.length
	}

	func isBlocked(by vector: Vector) -> Bool {
		vector.isCodirectional(to: self)
			&& vector.length < self.length
			&& dx * vector.dx >= 0
			&& dy * vector.dy >= 0
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
			var vectors = asteroid.vectors(to: asteroids)
			vectors = vectors.filter {
				!vectors.contains(where: $0.isBlocked)
			}

			if bestAsteroid.amount < vectors.count {
				bestAsteroid = (asteroid, vectors.count)
			}
		}

		return bestAsteroid
	}
}
