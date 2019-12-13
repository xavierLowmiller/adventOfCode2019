import IntCode

struct Tile {
	enum Kind: Int {
		case empty, wall, block, paddle, ball
	}

	let x: Int
	let y: Int
	let kind: Kind
}

final class Game {
	private let computer: Computer
	var tiles: [Tile] = []
	var score = 0

	init(memory: [Int]) {
		computer = Computer(memory: memory)
	}

	func drawDefaultBoard() {
		tiles = computer
			.chunked(into: 3)
			.filter { $0[0] != -1 }
			.map { Tile(x: $0[0], y: $0[1], kind: Tile.Kind(rawValue: $0[2])!) }
	}

	func play() -> Int {

		var lastPaddleX: Int?
		var lastBallX: Int?
		var joystickPosition = 0
		var score = 0

		var outputs: [Int] = []

		while let output = computer.execute(input: joystickPosition) {
			outputs.append(output)

			switch outputs.count {
			case 1, 2:
				continue
			case 3:
				defer { outputs = [] }

				guard outputs[0] != -1 else {
					score = outputs[2]
					continue
				}

				let tile = Tile(x: outputs[0],
												y: outputs[1],
												kind: Tile.Kind(rawValue: outputs[2])!)

				if tile.kind == .ball {
					lastBallX = tile.x
				}
				if tile.kind == .paddle {
					lastPaddleX = tile.x
				}

				if let lastBallX = lastBallX, let lastPaddleX = lastPaddleX {
					if lastBallX < lastPaddleX {
						joystickPosition = -1
					} else if lastBallX > lastPaddleX {
						joystickPosition = 1
					} else {
						joystickPosition = 0
					}
				}

			default:
				fatalError()
			}
		}

		return score
	}
}

extension Game: CustomStringConvertible {
	var description: String {
		let maxX = tiles.map { $0.x }.max() ?? 0
		let maxY = tiles.map { $0.y }.max() ?? 0
		var board: [[Character]] = Array(repeating: Array(repeating: " ", count: maxX + 1), count: maxY + 1)

		for tile in tiles {
			switch tile.kind {
			case .empty:
				board[tile.y][tile.x] = " "
			case .wall:
				board[tile.y][tile.x] = "|"
			case .block:
				board[tile.y][tile.x] = "X"
			case .paddle:
				board[tile.y][tile.x] = "_"
			case .ball:
				board[tile.y][tile.x] = "o"
			}
		}

		let lines = board.map { String($0) } + ["", "Score: \(score)"]
		return lines.joined(separator: "\n")
	}
}
