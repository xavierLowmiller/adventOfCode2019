import IntCode

extension Int {
	static let north = 1
	static let south = 2
	static let west = 3
	static let east = 4

	static let wall = 0
	static let free = 1
	static let oxygen = 2

	var right: Int {
		switch self {
		case .north:
			return .east
		case .east:
			return .south
		case .south:
			return .west
		case .west:
			return .north
		default:
			fatalError()
		}
	}

	var left: Int {
		switch self {
		case .north:
			return .west
		case .east:
			return .north
		case .south:
			return .east
		case .west:
			return .south
		default:
			fatalError()
		}
	}
}

struct Point: Hashable {
	let x: Int
	let y: Int

	static let zero = Point(x: 0, y: 0)

	func nextPoint(given direction: Int) -> Point {
		switch direction {
		case .north:
			return Point(x: x, y: y + 1)
		case .south:
			return Point(x: x, y: y - 1)
		case .west:
			return Point(x: x - 1, y: y)
		case .east:
			return Point(x: x + 1, y: y)
		default:
			fatalError()
		}
	}

	func manhattanDistance(to point: Point) -> Int {
		abs(x - point.x) + abs(y - point.y)
	}

	var neighbors: [Point] {
		[
			nextPoint(given: .north),
			nextPoint(given: .south),
			nextPoint(given: .west),
			nextPoint(given: .east)
		]
	}
}

final class Robot {
	private let computer: Computer
	private var map: [Point: Int] = [.zero: .free]
	private var currentPoint: Point = .zero

	init(memory: [Int]) {
		computer = Computer(memory: memory)
		discoverMap()
	}

	private func discoverMap() {
		var currentDirection: Int = .north
		while currentPoint != .zero || map.count < 100 {
			// Always try to go right
			let output = computer.execute(input: currentDirection.right)

			switch output {
			case .wall?:
				map[currentPoint.nextPoint(given: currentDirection.right)] = .wall
				currentDirection = currentDirection.left
			case .free?, .oxygen?:
				map[currentPoint.nextPoint(given: currentDirection.right)] = output
				currentPoint = currentPoint.nextPoint(given: currentDirection.right)
				currentDirection = currentDirection.right
			default:
				break
			}
		}
	}

	func findShortestPathToOxygen() -> Int {
		return aStar().count - 1
	}

	func findLongestPathToOxygen() -> Int {
		map
			.filter { $0.value == .free }
			.keys
			.map(aStar)
			.map { $0.count - 1 }
			.max() ?? 0
	}

	private func aStar(start: Point = .zero) -> [Point] {
		let goal = map.first { $0.value == .oxygen }!.key

		let h: (Point) -> Int = goal.manhattanDistance

		// The set of discovered nodes that may need to be (re-)expanded.
		// Initially, only the start node is known.
		var openSet: Set<Point> = [start]

		// For node n, cameFrom[n] is the node immediately preceding it on the cheapest path from start to n currently known.
		var cameFrom: [Point: Point] = [:]

		// For node n, gScore[n] is the cost of the cheapest path from start to n currently known.
		var gScore: [Point: Int] = map.keys.reduce(into: [:]) { $0[$1] = .max }
		gScore[start] = 0

		// For node n, fScore[n] := gScore[n] + h(n).
		var fScore: [Point: Int] = map.keys.reduce(into: [:]) { $0[$1] = .max }
		fScore[start] = h(start)

		while !openSet.isEmpty {
			let current = openSet.min(by: { fScore[$0]! < fScore[$1]! })!
			guard current != goal else {
				return reconstructPath(from: current, in: cameFrom)
			}

			openSet.remove(current)
			let neighbors = current.neighbors.filter { map[$0] != .wall }
			for neighbor in neighbors {

				// d(current,neighbor) is the weight of the edge from current to neighbor
				// tentative_gScore is the distance from start to the neighbor through current
				let tentative_gScore = gScore[current]! + 1

				// This path to neighbor is better than any previous one. Record it!
				if tentative_gScore < gScore[neighbor]! {
					cameFrom[neighbor] = current
					gScore[neighbor] = tentative_gScore
					fScore[neighbor] = gScore[neighbor]! + h(neighbor)

					openSet.insert(neighbor)
				}
			}
		}

		return []
	}

	private func reconstructPath(from: Point, in cameFrom: [Point: Point]) -> [Point] {
		var path = [from]
		var current = from
		while let next = cameFrom[current] {
			path.append(next)
			current = next
		}
		return Array(path.reversed())
	}
}

private func drawMap(_ map: [Point: Int]) {
	let xBounds = (map.keys.map { $0.x }.min()!, map.keys.map { $0.x }.max()!)
	let yBounds = (map.keys.map { $0.y }.min()!, map.keys.map { $0.y }.max()!)

	var result = ""

	for x in xBounds.0...xBounds.1 {
		for y in yBounds.0...yBounds.1 {
			let point = Point(x: x, y: y)

			guard point != .zero else {
				result.append("A")
				continue
			}

			switch map[point] {
			case nil, .wall?:
				result.append("#")
			case .free?:
				result.append(" ")
			case .oxygen?:
				result.append("Z")
			default:
				fatalError()
			}
		}
		result.append("\n")
	}

	print(result)
}
