struct Board: CustomStringConvertible, Equatable {
	var cells: [[Bool]] = Array(repeating: Array(repeating: false, count: 5), count: 5)

	init(input: String) {
		for (y, line) in input.split(separator: "\n").enumerated() {
			for (x, character) in line.enumerated() {
				cells[y][x] = character == "#"
			}
		}
	}

	static let empty = Board(input: """
		.....
		.....
		.....
		.....
		.....
		""")

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

	mutating func tick() {
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

	func foldedNeighbors(of position: (x: Int, y: Int),
											 lowerLevel: Board,
											 upperLevel: Board) -> [Bool] {
		let (x, y) = position
		var result: [Bool] = []

		switch (x, y) {
		// middle
		case (2, 2):
			break

		// outer corners
		// top left
		case (0, 0):
			result.append(cells[y + 1][x])
			result.append(cells[y][x + 1])
			result.append(upperLevel.cells[1][2])
			result.append(upperLevel.cells[2][1])
		// top right
		case (4, 0):
			result.append(cells[y + 1][x])
			result.append(cells[y][x - 1])
			result.append(upperLevel.cells[1][2])
			result.append(upperLevel.cells[2][3])
		// bottom left
		case (0, 4):
			result.append(cells[y - 1][x])
			result.append(cells[y][x + 1])
			result.append(upperLevel.cells[3][2])
			result.append(upperLevel.cells[2][1])
		// bottom right
		case (4, 4):
			result.append(cells[y - 1][x])
			result.append(cells[y][x - 1])
			result.append(upperLevel.cells[3][2])
			result.append(upperLevel.cells[2][3])

		// left inner edge
		case (1, 2):
			result.append(cells[y][x - 1])
			result.append(cells[y - 1][x])
			result.append(cells[y + 1][x])
			result.append(lowerLevel.cells[0][0])
			result.append(lowerLevel.cells[1][0])
			result.append(lowerLevel.cells[2][0])
			result.append(lowerLevel.cells[3][0])
			result.append(lowerLevel.cells[4][0])

		// right inner edge
		case (3, 2):
			result.append(cells[y][x + 1])
			result.append(cells[y - 1][x])
			result.append(cells[y + 1][x])
			result.append(lowerLevel.cells[0][4])
			result.append(lowerLevel.cells[1][4])
			result.append(lowerLevel.cells[2][4])
			result.append(lowerLevel.cells[3][4])
			result.append(lowerLevel.cells[4][4])

		// top inner edge
		case (2, 1):
			result.append(cells[y][x - 1])
			result.append(cells[y][x + 1])
			result.append(cells[y - 1][x])
			result.append(lowerLevel.cells[0][0])
			result.append(lowerLevel.cells[0][1])
			result.append(lowerLevel.cells[0][2])
			result.append(lowerLevel.cells[0][3])
			result.append(lowerLevel.cells[0][4])

		// bottom inner edge
		case (2, 3):
			result.append(cells[y][x - 1])
			result.append(cells[y][x + 1])
			result.append(cells[y + 1][x])
			result.append(lowerLevel.cells[4][0])
			result.append(lowerLevel.cells[4][1])
			result.append(lowerLevel.cells[4][2])
			result.append(lowerLevel.cells[4][3])
			result.append(lowerLevel.cells[4][4])

		// outer edges
		// left edge
		case (0, _):
			result.append(cells[y - 1][x])
			result.append(cells[y + 1][x])
			result.append(cells[y][x + 1])
			result.append(upperLevel.cells[2][1])
		// right edge
		case (4, _):
			result.append(cells[y - 1][x])
			result.append(cells[y + 1][x])
			result.append(cells[y][x - 1])
			result.append(upperLevel.cells[2][3])
		// top edge
		case (_, 0):
			result.append(cells[y][x - 1])
			result.append(cells[y + 1][x])
			result.append(cells[y][x + 1])
			result.append(upperLevel.cells[1][2])
		// bottom edge
		case (_, 4):
			result.append(cells[y][x - 1])
			result.append(cells[y - 1][x])
			result.append(cells[y][x + 1])
			result.append(upperLevel.cells[3][2])

		// Regular cells
		case (_, _):
			result.append(cells[y][x - 1])
			result.append(cells[y][x + 1])
			result.append(cells[y - 1][x])
			result.append(cells[y + 1][x])
		}

		return result
	}

	mutating func foldedTick(lowerLevel: Board,
									upperLevel: Board) {
		var nextGen = cells
		for (y, line) in cells.enumerated() {
			for (x, isAlive) in line.enumerated() {
				let neighbors = foldedNeighbors(
					of: (x, y),
					lowerLevel: lowerLevel,
					upperLevel: upperLevel
				)
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

	var bugCount: Int {
		cells.compactMap { $0.filter { $0 }.count }.reduce(0, +)
	}

	mutating func findRepeatingConfig() -> Int {
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

	static func == (lhs: Board, rhs: Board) -> Bool {
		lhs.cells == rhs.cells
	}
}
