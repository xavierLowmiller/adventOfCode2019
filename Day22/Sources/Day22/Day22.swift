final class CardDeck {
	private(set) var cards: [Int]

	init(amount: Int) {
		cards = Array(0..<amount)
	}

	func dealIntoNewStack() {
		cards.reverse()
	}

	func cut(_ n: Int) {
		if n > 0 {
			let head = cards.prefix(n)
			let tail = cards.dropFirst(n)
			cards = Array(tail + head)
		} else {
			let n = cards.count + n
			let head = cards.prefix(n)
			let tail = cards.dropFirst(n)
			cards = Array(tail + head)
		}
	}

	func dealWithIncrement(_ increment: Int) {
		var index = 0
		var target = Array(repeating: -1, count: cards.count)

		while !cards.isEmpty {
			target[index] = cards.removeFirst()
			index += increment
			index %= target.count
		}

		cards = target
	}

	func performCommands<S: StringProtocol>(_ commands: [S]) {
		var commands = commands
		while !commands.isEmpty {
			let command = commands.removeFirst()
			switch command {
			case "deal into new stack":
				dealIntoNewStack()
			case _ where command.hasPrefix("cut"):
				let n = Int(command.split(separator: " ").last!)!
				cut(n)
			case _ where command.hasPrefix("deal with increment"):
				let increment = Int(command.split(separator: " ").last!)!
				dealWithIncrement(increment)
			default:
				fatalError("Unknown command")
			}
		}
	}
}
