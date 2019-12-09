/// The IntCode computer
public final class Computer {
	private(set) public var memory: [Int]

	private var programCounter = 0
	private var relativeBase = 0

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
		switch instruction.arg1Mode {
		case .position:
			return memory[safe: memory[safe: programCounter + 1]]
		case .immediate:
			return memory[programCounter + 1]
		case .relative:
			return memory[relativeBase + memory[programCounter + 1]]
		}
	}

	private func arg2(for instruction: Instruction) -> Int {
		switch instruction.arg2Mode {
		case .position:
			return memory[safe: memory[safe: programCounter + 2]]
		case .immediate:
			return memory[programCounter + 2]
		case .relative:
			return memory[relativeBase + memory[programCounter + 2]]
		}
	}

	private func arg3(for instruction: Instruction) -> Int {
		switch instruction.arg3Mode {
		case .position:
			return memory[safe: memory[safe: programCounter + 3]]
		case .immediate:
			return memory[programCounter + 3]
		case .relative:
			return memory[relativeBase + memory[programCounter + 3]]
		}
	}

	/// Manipulates the memory according to the Instruction
	///
	/// - Parameter memory: the memory to operate on
	private func execute(instruction: Instruction, input: inout [Int]) -> Int? {
		switch instruction.opCode {
		case 1: // Add
			memory[safe: memory[safe: programCounter + 3]] = arg1(for: instruction) + arg2(for: instruction)
			programCounter += 4
		case 2: // Multiply
			memory[safe: memory[safe: programCounter + 3]] = arg1(for: instruction) * arg2(for: instruction)
			programCounter += 4
		case 3: // Assign
			switch instruction.arg1Mode {
			case .position:
				memory[safe: memory[safe: programCounter + 1]] = input.removeFirst()
			case .immediate:
				memory[programCounter + 1] = input.removeFirst()
			case .relative:
				memory[relativeBase + memory[programCounter + 1]] = input.removeFirst()
			}
			programCounter += 2
		case 4: // Read
			defer { programCounter += 2 }
			switch instruction.arg1Mode {
			case .position:
				return memory[safe: memory[safe: programCounter + 1]]
			case .immediate:
				return memory[programCounter + 1]
			case .relative:
				return memory[relativeBase + memory[programCounter + 1]]
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
				memory[safe: memory[safe: programCounter + 3]] = 1
			} else {
				memory[safe: memory[safe: programCounter + 3]] = 0
			}
			programCounter += 4
		case 8: // Equals
			if arg1(for: instruction) == arg2(for: instruction) {
				memory[safe: memory[safe: programCounter + 3]] = 1
			} else {
				memory[safe: memory[safe: programCounter + 3]] = 0
			}
			programCounter += 4
		case 9: // Adjust relative base
			relativeBase += arg1(for: instruction)
			programCounter += 2

		case 99: // Halt
			return -1
		default:
			fatalError("Invalid opcode \(instruction.opCode) at \(programCounter)")
		}

		return nil
	}
}

private extension Array where Element == Int {
	subscript(safe index: Int) -> Element {
		get {
			if index >= count {
				return 0
			} else {
				return self[index]
			}
		}
		set {
			if index >= count {
				self += Array(repeating: 0, count: index - count + 1)
			}
			self[index] = newValue
		}
	}
}
