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

extension Array where Element == Direction {
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

// Debug
extension Array where Element == Set<Point> {
	var description: String {
		let allPoints = self.flatMap { $0 }
		let intersections = self[0].intersection(self[1])
		let yMin = allPoints.map { $0.y }.min() ?? 0
		let yMax = allPoints.map { $0.y }.max() ?? 0
		let xMin = allPoints.map { $0.x }.min() ?? 0
		let xMax = allPoints.map { $0.x }.max() ?? 0

		var result = ""
		for y in yMin...yMax {
			for x in xMin...xMax {
				let point = Point(x: x, y: y)
				if point == .zero {
					result.append("o")
				} else if intersections.contains(point) {
					result.append("X")
				} else if allPoints.contains(point) {
					result.append(".")
				} else {
					result.append(" ")
				}
			}
			result.append("\n")
		}

		return result
	}
}
