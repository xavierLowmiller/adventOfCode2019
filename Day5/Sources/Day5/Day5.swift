struct Instruction {
	let arg1IsImmediate: Bool
	let arg2IsImmediate: Bool
	let arg3IsImmediate: Bool
	let input: Int
	let opCode: Int

	init(opCode: Int, input: Int) {
		self.opCode = opCode % 100
		arg1IsImmediate = opCode / 100 % 10 == 1
		arg2IsImmediate = opCode / 1000 % 10 == 1
		arg3IsImmediate = opCode / 10000 % 10 == 1
		self.input = input
	}

	/// Manipulates the memory according to the opcode
	///
	/// Returns the new instruction pointer
	/// - Parameter memory: the memory to operate on
	func execute(on memory: inout [Int], pointer: Int) -> Int {
		switch opCode {
		case 1: // Add
			let arg1 = arg1IsImmediate ? memory[pointer + 1] : memory[memory[pointer + 1]]
			let arg2 = arg2IsImmediate ? memory[pointer + 2] : memory[memory[pointer + 2]]
			memory[memory[pointer + 3]] = arg1 + arg2
			return pointer + 4
		case 2: // Multiply
			let arg1 = arg1IsImmediate ? memory[pointer + 1] : memory[memory[pointer + 1]]
			let arg2 = arg2IsImmediate ? memory[pointer + 2] : memory[memory[pointer + 2]]
			memory[memory[pointer + 3]] = arg1 * arg2
			return pointer + 4
		case 3: // Assign
			if arg1IsImmediate {
				memory[pointer + 1] = input
			} else {
				memory[memory[pointer + 1]] = input
			}
			return pointer + 2
		case 4: // Read
			if arg1IsImmediate {
				print(memory[pointer + 1])
			} else {
				print(memory[memory[pointer + 1]])
			}
			return pointer + 2
		case 99: // Halt
			return pointer + 1
		default:
			fatalError("Invalid opcode \(opCode) at \(pointer)")
		}
	}
}

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
			let instruction = Instruction(opCode: memory[instructionPointer], input: input)
			instructionPointer = instruction.execute(on: &memory, pointer: instructionPointer)
		}
	}
}
