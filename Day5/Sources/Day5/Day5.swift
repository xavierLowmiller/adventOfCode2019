final class IntCode {
	private(set) var memory: [Int]
	private var input: Int

	private var instructionPointer = 0

	init(memory: [Int], input: Int = 0) {
		self.memory = memory
		self.input = input
	}

	func execute() {
		while memory[instructionPointer] != 99 {
			switch memory[instructionPointer] {
			case 1:
				memory[memory[instructionPointer + 3]] = memory[memory[instructionPointer + 1]] + memory[memory[instructionPointer + 2]]
				instructionPointer += 4
			case 2:
				memory[memory[instructionPointer + 3]] = memory[memory[instructionPointer + 1]] * memory[memory[instructionPointer + 2]]
				instructionPointer += 4
			case 3:
				memory[memory[instructionPointer + 1]] = input
				instructionPointer += 2
			case 4:
				print(memory[memory[instructionPointer + 1]])
				instructionPointer += 2
			case 99:
				instructionPointer += 1
				return
			case 101:
				memory[memory[instructionPointer + 3]] = memory[instructionPointer + 1] + memory[memory[instructionPointer + 2]]
				instructionPointer += 4
			case 102:
				memory[memory[instructionPointer + 3]] = memory[instructionPointer + 1] * memory[memory[instructionPointer + 2]]
				instructionPointer += 4
			case 103:
				memory[instructionPointer + 1] = input
				instructionPointer += 2
			case 104:
				print(memory[instructionPointer + 1])
				instructionPointer += 2
			case 1001:
				memory[memory[instructionPointer + 3]] = memory[memory[instructionPointer + 1]] + memory[instructionPointer + 2]
				instructionPointer += 4
			case 1002:
				memory[memory[instructionPointer + 3]] = memory[memory[instructionPointer + 1]] * memory[instructionPointer + 2]
				instructionPointer += 4
			case 1101:
				memory[memory[instructionPointer + 3]] = memory[instructionPointer + 1] + memory[instructionPointer + 2]
				instructionPointer += 4
			case 1102:
				memory[memory[instructionPointer + 3]] = memory[instructionPointer + 1] * memory[instructionPointer + 2]
				instructionPointer += 4
			default:
				fatalError("Invalid opcode \(memory[instructionPointer]) at \(instructionPointer)")
			}
		}
	}

	var output: Int {
		memory[0]
	}
}
