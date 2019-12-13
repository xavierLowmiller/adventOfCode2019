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
	let tiles: [Tile]

	init(memory: [Int]) {
		let computer = Computer(memory: memory)

		tiles = computer
			.chunked(into: 3)
			.map { Tile(x: $0[0], y: $0[1], kind: Tile.Kind(rawValue: $0[2])!) }
	}
}

extension Computer: Sequence, IteratorProtocol {
	public func next() -> Int? {
		execute()
	}
}

extension Sequence {
	func chunked(into size: Int) -> [[Self.Element]] {
		reduce(into: []) { result, current in

			if let last = result.last, last.count < size {
				result.append(result.removeLast() + [current])
			} else {
				result.append([current])
			}

		}
	}
}
