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

	var positionsVisited: [Position: Int] = [:]
	var currentPosition = Position.zero
	var currentDirection: Direction = .up

	init(memory: [Int]) {
		brain = Computer(memory: memory)
	}

	func paint() {

		var code: Int? = 0

		while let input = code,
			let newColor = brain.execute(input: input),
			let turnDirection = brain.execute(input: input) {

				// Paint
				positionsVisited[currentPosition] = newColor
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

				code = positionsVisited[currentPosition] ?? 0
		}
	}
}
