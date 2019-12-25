final class FoldedSpace {
	var levels: [Int: Board]

	init(input: String) {
		levels = [
			-1: .empty,
			0: Board(input: input),
			1: .empty
		]
	}

	var bugCount: Int {
		levels.values.map { $0.bugCount }.reduce(0, +)
	}

	func tick() {
		guard
			let lowestLevel = levels.keys.min(),
			let uppermostLevel = levels.keys.max()
			else { return }

		var nextGeneration: [Int: Board] = [:]

		for key in lowestLevel...uppermostLevel {
			var board = levels[key]
			board?.foldedTick(
				lowerLevel: levels[key - 1] ?? .empty,
				upperLevel: levels[key + 1] ?? .empty
			)
			nextGeneration[key] = board
		}

		levels = nextGeneration

		if levels[lowestLevel] != .empty {
			levels[lowestLevel - 1] = .empty
		}

		if levels[uppermostLevel] != .empty {
			levels[uppermostLevel + 1] = .empty
		}
	}
}
