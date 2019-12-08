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
	func execute(on memory: inout [Int], input: inout [Int], pointer: Int, output: (Int) -> Void) -> Int {
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
				output(memory[pointer + 1])
			} else {
				output(memory[memory[pointer + 1]])
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
			return -1
		default:
			fatalError("Invalid opcode \(opCode) at \(pointer)")
		}
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
			programCounter = instruction.execute(
				on: &memory,
				input: &input,
				pointer: programCounter
			) { output = $0 }
		}

		return output
	}
}
