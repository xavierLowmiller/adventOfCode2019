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
}

/// The IntCode computer
public final class Computer {
	private(set) public var memory: [Int]

	private var programCounter = 0

	/// Loads a program into the computer's memory
	/// - Parameter memory: The program to be executed
	public init(memory: [Int]) {
		self.memory = memory
	}

	/// Executes the program from the current program counter onwards
	/// until an output is produced or the halt instruction is found
	/// - Parameter input: Any input arguments
	@discardableResult
	public func execute(input: Int...) -> Int? {
		var input = input
		var output: Int?
		while memory[programCounter] != 99, output == nil {
			let instruction = Instruction(opCode: memory[programCounter])
			output = execute(instruction: instruction, input: &input)
		}

		return output
	}

	private func arg1(for instruction: Instruction) -> Int {
		instruction.arg1IsImmediate
			? memory[programCounter + 1]
			: memory[memory[programCounter + 1]]
	}

	private func arg2(for instruction: Instruction) -> Int {
		instruction.arg2IsImmediate
			? memory[programCounter + 2]
			: memory[memory[programCounter + 2]]
	}

	private func arg3(for instruction: Instruction) -> Int {
		instruction.arg3IsImmediate
			? memory[programCounter + 3]
			: memory[memory[programCounter + 3]]
	}

	/// Manipulates the memory according to the Instruction
	///
	/// - Parameter memory: the memory to operate on
	private func execute(instruction: Instruction, input: inout [Int]) -> Int? {
		switch instruction.opCode {
		case 1: // Add
			memory[memory[programCounter + 3]] = arg1(for: instruction) + arg2(for: instruction)
			programCounter += 4
		case 2: // Multiply
			memory[memory[programCounter + 3]] = arg1(for: instruction) * arg2(for: instruction)
			programCounter += 4
		case 3: // Assign
			if instruction.arg1IsImmediate {
				memory[programCounter + 1] = input.removeFirst()
			} else {
				memory[memory[programCounter + 1]] = input.removeFirst()
			}
			programCounter += 2
		case 4: // Read
			defer { programCounter += 2 }
			if instruction.arg1IsImmediate {
				return memory[programCounter + 1]
			} else {
				return memory[memory[programCounter + 1]]
			}
		case 5: // Jump if true
			if arg1(for: instruction) != 0 {
				programCounter = arg2(for: instruction)
			} else {
				programCounter += 3
			}
		case 6: // Jump if false
			if arg1(for: instruction) == 0 {
				programCounter = arg2(for: instruction)
			} else {
				programCounter += 3
			}
		case 7: // Less Than
			if arg1(for: instruction) < arg2(for: instruction) {
				memory[memory[programCounter + 3]] = 1
			} else {
				memory[memory[programCounter + 3]] = 0
			}
			programCounter += 4
		case 8: // Equals
			if arg1(for: instruction) == arg2(for: instruction) {
				memory[memory[programCounter + 3]] = 1
			} else {
				memory[memory[programCounter + 3]] = 0
			}
			programCounter += 4

		case 99: // Halt
			return -1
		default:
			fatalError("Invalid opcode \(instruction.opCode) at \(programCounter)")
		}

		return nil
	}
}
