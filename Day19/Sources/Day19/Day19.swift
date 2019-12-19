import IntCode

struct Point: Hashable {
	var x: Int
	var y: Int
}

final class TractorBeam {
	private let memory: [Int]

	init(memory: [Int]) {
		self.memory = memory
	}

	func pointsAffectedByTractorBeam(in range: Int) -> [[Int]] {

		var result: [[Int]] = Array(repeating: Array(repeating: 0, count: range), count: range)

		for x in 0..<range {
			for y in 0..<range {
				result[y][x] = valueAt(x: x, y: y)
			}
		}

		return result
	}

	private func valueAt(x: Int, y: Int) -> Int {
		let computer = Computer(memory: memory)
		return computer.execute(input: x, y)!
	}

	var coordinateOfFirst100By100Square: Point {
		var x = 0
		for y in 100... {
			while valueAt(x: x, y: y) == 0 {
				x += 1
			}
			if valueAt(x: x + 99, y: y - 99) == 1, valueAt(x: x, y: y - 99) == 1 {
				return Point(x: x, y: y - 99)
			}
		}
		fatalError()
	}
}

extension Array where Element == [Int] {
	var description: String {

		var result = ""
		for line in self {
			for value in line {
				switch value {
				case 0:
					result.append(".")
				case 1:
					result.append("#")
				default:
					fatalError()
				}
			}
			result.append("\n")
		}

		return result
	}
}
