import IntCode

extension Computer: Sequence, IteratorProtocol {
	public func next() -> Int? {
		execute()
	}
}

extension Array where Element == [Character] {
	func neighbors(at position: (x: Int, y: Int)) -> [Character] {
		let (x, y) = position
		var neighbors: [Character] = []

		if x - 1 > 0 {
			neighbors.append(self[y][x - 1])
		}
		if x + 1 < self[y].count {
			neighbors.append(self[y][x + 1])
		}
		if y - 1 > 0 {
			neighbors.append(self[y - 1][x])
		}
		if y + 1 < self.count {
			neighbors.append(self[y + 1][x])
		}

		return neighbors
	}
}

final class Robot {
	let computer: Computer
	init(memory: [Int]) {
		computer = Computer(memory: memory)
	}

	var image: String {
		String(computer
			.compactMap { UnicodeScalar($0) }
			.compactMap(Character.init))
	}

	var imageChecksum: Int {
		var result = 0

		let lines = image.split(separator: "\n").map(Array.init)
		for (y, line) in lines.enumerated() {
			for (x, character) in line.enumerated() {
				let neighbors = lines.neighbors(at: (x, y))
				if character == "#", neighbors == ["#", "#", "#", "#"] {
					result += x * y
				}
			}
		}

		return result
	}
}
