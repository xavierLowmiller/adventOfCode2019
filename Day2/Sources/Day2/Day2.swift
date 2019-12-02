final class IntCode {
	private(set) var input: [Int]

	private var currentIndex = 0

	init(input: [Int]) {
		self.input = input
	}

	func execute() {
		while input[currentIndex] != 99 {
			switch input[currentIndex] {
			case 1:
				input[input[currentIndex + 3]] = input[input[currentIndex + 1]] + input[input[currentIndex + 2]]
			case 2:
				input[input[currentIndex + 3]] = input[input[currentIndex + 1]] * input[input[currentIndex + 2]]
			default:
				fatalError("Invalid opcode \(input[currentIndex]) at \(currentIndex)")
			}
			currentIndex += 4
		}
	}

	var output: Int {
		input[0]
	}
}
