final class Board: CustomStringConvertible {
	var cells: [[Bool]] = Array(repeating: Array(repeating: false, count: 5), count: 5)

	init(input: String) {
		for (y, line) in input.split(separator: "\n").enumerated() {
			for (x, character) in line.enumerated() {
				cells[y][x] = character == "#"
			}
		}
	}

	private func neighbors(of position: (x: Int, y: Int)) -> [Bool] {
		let (x, y) = position
		var result: [Bool] = []

		if x > 0 {
			result.append(cells[y][x - 1])
		}

		if x < cells[y].count - 1 {
			result.append(cells[y][x + 1])
		}

		if y > 0 {
			result.append(cells[y - 1][x])
		}

		if y < cells.count - 1 {
			result.append(cells[y + 1][x])
		}

		return result
	}

	func tick() {
		var nextGen = cells
		for (y, line) in cells.enumerated() {
			for (x, isAlive) in line.enumerated() {
				let neighbors = self.neighbors(of: (x, y))
				let livingNeighbors = neighbors.filter { $0 }.count

				switch (isAlive, livingNeighbors) {
				case (true, 1):
					// Cell stays alive
					break
				case (true, _):
					// Cell dies
					nextGen[y][x] = false
				case (false, 1...2):
					// Cell becomes infested
					nextGen[y][x] = true
				case (false, _):
					// Cell stays dead
					break
				}
			}
		}
		cells = nextGen
	}

	var score: Int {
		var result = 0
		var currentScore = 1
		for line in cells {
			for isAlive in line {
				if isAlive {
					result += currentScore
				}
				currentScore *= 2
			}
		}

		return result
	}

	func findRepeatingConfig() -> Int {
		var scores: Set<Int> = []
		while true {
			let score = self.score
			if scores.contains(score) {
				return score
			} else {
				scores.insert(score)
			}
			tick()
		}
	}

	var description: String {
		cells.map { line in
			line.map { $0 ? "#" : "." }.joined()
		}.joined(separator: "\n")
	}
}
