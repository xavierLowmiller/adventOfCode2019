import IntCode

struct Position: Hashable {
	let x: Int
	let y: Int

	static let zero: Position = Position(x: 0, y: 0)
}

enum Direction {
	case left, up, down, right

	func newDirection(for input: Int) -> Direction {
		switch (input, self) {
		// 0 => left
		case (0, .left):
			return .down
		case (0, .up):
			return .left
		case (0, .down):
			return .right
		case (0, .right):
			return .up
		// 1 => right
		case (1, .left):
			return .up
		case (1, .up):
			return .right
		case (1, .down):
			return .left
		case (1, .right):
			return .down

		default:
			fatalError("Unsupported direction")
		}
	}
}

final class Robot {
	let brain: Computer
	let baseColor: Int

	var positions: [Position: Int] = [:]
	var currentPosition = Position.zero
	var currentDirection: Direction = .up

	init(memory: [Int], baseColor: Int) {
		brain = Computer(memory: memory)
		self.baseColor = baseColor
	}

	func paint() {

		var code: Int? = baseColor

		while let input = code,
			let newColor = brain.execute(input: input),
			let turnDirection = brain.execute(input: input) {

				// Paint
				positions[currentPosition] = newColor
				// Turn
				currentDirection = currentDirection.newDirection(for: turnDirection)

				// Move
				switch currentDirection {
				case .left:
					currentPosition = Position(x: currentPosition.x - 1, y: currentPosition.y)
				case .up:
					currentPosition = Position(x: currentPosition.x, y: currentPosition.y - 1)
				case .down:
					currentPosition = Position(x: currentPosition.x, y: currentPosition.y + 1)
				case .right:
					currentPosition = Position(x: currentPosition.x + 1, y: currentPosition.y)
				}

				code = positions[currentPosition] ?? baseColor
		}
	}

	var painting: String {
		var array: [[Character]] = []

		let minX = positions.keys.map { $0.x }.min() ?? 0
		let maxX = positions.keys.map { $0.x }.max() ?? 0
		let minY = positions.keys.map { $0.y }.min() ?? 0
		let maxY = positions.keys.map { $0.y }.max() ?? 0

		for y in minY...maxY {
			array.append([])
			for x in minX...maxX {
				let position = Position(x: x, y: y)
				let color = positions[position] ?? baseColor
				array[y - minY].append(color == 1 ? "⬜️" : "⬛️")
			}
		}

		return array
			.map { String($0) }
			.joined(separator: "\n")
	}
}
