private struct Point: Hashable {
	let x: Int
	let y: Int

	var distance: Int {
		abs(x) + abs(y)
	}

	static let zero = Point(x: 0, y: 0)
}

private enum Direction {
	case up(Int)
	case down(Int)
	case left(Int)
	case right(Int)

	init(string: Substring) {
		let direction = string.first!
		let distance = Int(String(string.dropFirst()))!
		switch direction {
		case "U":
			self = .up(distance)
		case "D":
			self = .down(distance)
		case "L":
			self = .left(distance)
		case "R":
			self = .right(distance)
		default:
			fatalError("Bad input: \(string)")
		}
	}

	func points(startingFrom point: Point) -> Set<Point> {
		var points: Set<Point> = []
		switch self {
		case .up(let distance):
			for i in 1...distance {
				points.insert(Point(x: point.x, y: point.y + i))
			}
		case .down(let distance):
			for i in 1...distance {
				points.insert(Point(x: point.x, y: point.y - i))
			}
		case .left(let distance):
			for i in 1...distance {
				points.insert(Point(x: point.x - i, y: point.y))
			}
		case .right(let distance):
			for i in 1...distance {
				points.insert(Point(x: point.x + i, y: point.y))
			}
		}
		return points
	}

	func nextPoint(startingAt point: Point) -> Point {
		switch self {
		case .up(let distance):
			return Point(x: point.x, y: point.y + distance)
		case .down(let distance):
			return Point(x: point.x, y: point.y - distance)
		case .left(let distance):
			return Point(x: point.x - distance, y: point.y)
		case .right(let distance):
			return Point(x: point.x + distance, y: point.y)
		}
	}
}

private extension Array where Element == Direction {
	var points: Set<Point> {
		var points: Set<Point> = []
		var currentPoint: Point = .zero
		for direction in self {
			points.formUnion(direction.points(startingFrom: currentPoint))
			currentPoint = direction.nextPoint(startingAt: currentPoint)
		}
		return points
	}
}

private func parseInput(_ input: String) -> [[Direction]] {
	input
		.split(separator: "\n")
		.map {
			$0.split(separator: ",")
				.map(Direction.init)
	}
}

func findClosestIntersection(of wires: String) -> Int {
	let wires = parseInput(wires).map { $0.points }
	let intersections = wires[0].intersection(wires[1])
	return intersections.map { $0.distance }.min() ?? 0
}

private extension Array where Element == Direction {
	func signalDelay(until intersections: Set<Point>) -> [Point: Int] {

		var result: [(point: Point, delay: Int)] = []

		for intersection in intersections {

			var steps = 0
			var point: Point = .zero

			directionLoop: for direction in self {
				switch direction {
				case .up(let distance):
					for _ in 1...distance {
						point = Point(x: point.x, y: point.y + 1)
						steps += 1
						if point == intersection {
							result.append((point, steps))
							break directionLoop
						}
					}
				case .down(let distance):
					for _ in 1...distance {
						point = Point(x: point.x, y: point.y - 1)
						steps += 1
						if point == intersection {
							result.append((point, steps))
							break directionLoop
						}
					}
				case .left(let distance):
					for _ in 1...distance {
						point = Point(x: point.x - 1, y: point.y)
						steps += 1
						if point == intersection {
							result.append((point, steps))
							break directionLoop
						}
					}
				case .right(let distance):
					for _ in 1...distance {
						point = Point(x: point.x + 1, y: point.y)
						steps += 1
						if point == intersection {
							result.append((point, steps))
							break directionLoop
						}
					}
				}
			}
		}

		return Dictionary(uniqueKeysWithValues: result)
	}
}

func signalDelay(of wires: String) -> Int {
	let directions = parseInput(wires)
	let wires = directions.map { $0.points }
	let intersections = wires[0].intersection(wires[1])

	let delaysUntilPoints = directions.map { $0.signalDelay(until: intersections) }

	let totalDelayPerPoint: [Point: Int] = intersections.reduce(into: [:]) { (result, point) in
		for delay in delaysUntilPoints {
			result[point, default: 0] += delay[point] ?? 0
		}
	}

	return totalDelayPerPoint.values.min() ?? 0
}
