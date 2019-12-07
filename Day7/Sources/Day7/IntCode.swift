struct Instruction {
	let arg1IsImmediate: Bool
	let arg2IsImmediate: Bool
	let arg3IsImmediate: Bool
	let opCode: Int

	init(opCode: Int) {
		self.opCode = opCode % 100
		arg1IsImmediate = opCode / 100 % 10 == 1
		arg2IsImmediate = opCode / 1000 % 10 == 1
		arg3IsImmediate = opCode / 10000 % 10 == 1
	}

	/// Manipulates the memory according to the opcode
	///
	/// Returns the new instruction pointer
	/// - Parameter memory: the memory to operate on
	func execute(on memory: inout [Int], input: inout [Int], output: inout Int, pointer: Int) -> Int {
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
				memory[pointer + 1] = input.removeFirst()
			} else {
				memory[memory[pointer + 1]] = input.removeFirst()
			}
			return pointer + 2
		case 4: // Read
			if arg1IsImmediate {
				output = memory[pointer + 1]
			} else {
				output = memory[memory[pointer + 1]]
			}
			return pointer + 2
		case 5: // Jump if true
			let arg1 = arg1IsImmediate ? memory[pointer + 1] : memory[memory[pointer + 1]]
			let arg2 = arg2IsImmediate ? memory[pointer + 2] : memory[memory[pointer + 2]]
			if arg1 != 0 {
				return arg2
			} else {
				return pointer + 3
			}
		case 6: // Jump if false
			let arg1 = arg1IsImmediate ? memory[pointer + 1] : memory[memory[pointer + 1]]
			let arg2 = arg2IsImmediate ? memory[pointer + 2] : memory[memory[pointer + 2]]
			if arg1 == 0 {
				return arg2
			} else {
				return pointer + 3
			}
		case 7: // Less Than
			let arg1 = arg1IsImmediate ? memory[pointer + 1] : memory[memory[pointer + 1]]
			let arg2 = arg2IsImmediate ? memory[pointer + 2] : memory[memory[pointer + 2]]
			if arg1 < arg2 {
				memory[memory[pointer + 3]] = 1
			} else {
				memory[memory[pointer + 3]] = 0
			}
			return pointer + 4
		case 8: // Equals
			let arg1 = arg1IsImmediate ? memory[pointer + 1] : memory[memory[pointer + 1]]
			let arg2 = arg2IsImmediate ? memory[pointer + 2] : memory[memory[pointer + 2]]
			if arg1 == arg2 {
				memory[memory[pointer + 3]] = 1
			} else {
				memory[memory[pointer + 3]] = 0
			}
			return pointer + 4

		case 99: // Halt
			return pointer + 1
		default:
			fatalError("Invalid opcode \(opCode) at \(pointer)")
		}
	}
}

final class IntCode {
	private(set) var memory: [Int]
	private(set) var output = 0 {
		didSet { outputSignal(output) }
	}
	private var input: [Int] = []

	var outputSignal: (Int) -> Void = { _ in }

	private var instructionPointer = 0

	init(memory: [Int]) {
		self.memory = memory
	}

	func execute(input: Int...) {
		self.input = input
		while memory[instructionPointer] != 99 {
			let instruction = Instruction(opCode: memory[instructionPointer])
			instructionPointer = instruction.execute(
				on: &memory,
				input: &self.input,
				output: &output,
				pointer: instructionPointer
			)
		}
	}
}
