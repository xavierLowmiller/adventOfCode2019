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
		return execute(input: &input)
	}

	/// Executes the program from the current program counter onwards
	/// until an output is produced or the halt instruction is found
	/// - Parameter input: Any input arguments
	@discardableResult
	public func execute(input: inout [Int]) -> Int? {
		var output: Int?
		while let instruction = Instruction(opCode: memory[programCounter]),
			instruction.operation != .halt,
			output == nil {
			output = execute(instruction: instruction, input: &input)
		}

		return output
	}

	private func arg1(for instruction: Instruction) -> Int {
		switch instruction.arg1Mode {
		case .position:
			return memory[safe: memory[safe: programCounter + 1]]
		case .immediate:
			return memory[safe: programCounter + 1]
		case .relative:
			return memory[safe: relativeBase + memory[safe: programCounter + 1]]
		}
	}

	private func arg2(for instruction: Instruction) -> Int {
		switch instruction.arg2Mode {
		case .position:
			return memory[safe: memory[safe: programCounter + 2]]
		case .immediate:
			return memory[safe: programCounter + 2]
		case .relative:
			return memory[safe: relativeBase + memory[safe: programCounter + 2]]
		}
	}

	private func arg3(for instruction: Instruction) -> Int {
		switch instruction.arg3Mode {
		case .position:
			return memory[safe: memory[safe: programCounter + 3]]
		case .immediate:
			return memory[safe: programCounter + 3]
		case .relative:
			return memory[safe: relativeBase + memory[safe: programCounter + 3]]
		}
	}

	private func writeAddress(for instruction: Instruction) -> Int {
		switch instruction.operation {
		case .add, .multiply, .lessThan, .equals:
			switch instruction.arg3Mode {
			case .position:
				return memory[safe: programCounter + 3]
			case .immediate:
				return programCounter + 3
			case .relative:
				return relativeBase + memory[safe: programCounter + 3]
			}
		case .assign:
			switch instruction.arg1Mode {
			case .position:
				return memory[safe: programCounter + 1]
			case .immediate:
				return programCounter + 1
			case .relative:
				return relativeBase + memory[safe: programCounter + 1]
			}
		default:
			fatalError("Instruction \(instruction) shouldn't write")
		}
	}

	/// Manipulates the memory according to the Instruction
	/// Returns any output made during the execution
	///
	/// - Parameters:
	///   - instruction: The instruction to execute
	///   - input: Any input parameters
	private func execute(instruction: Instruction, input: inout [Int]) -> Int? {
		defer {
			programCounter += instruction.programCounterIncrement
		}
		switch instruction.operation {
		case .add:
			memory[safe: writeAddress(for: instruction)] = arg1(for: instruction) + arg2(for: instruction)
		case .multiply:
			memory[safe: writeAddress(for: instruction)] = arg1(for: instruction) * arg2(for: instruction)
		case .assign:
			memory[safe: writeAddress(for: instruction)] = input.removeFirst()
		case .read:
			return arg1(for: instruction)
		case .jumpIfTrue:
			if arg1(for: instruction) != 0 {
				// Need to subtract 3 to counter the automatic increase
				programCounter = arg2(for: instruction) - 3
			}
		case .jumpIfFalse:
			if arg1(for: instruction) == 0 {
				// Need to subtract 3 to counter the automatic increase
				programCounter = arg2(for: instruction) - 3
			}
		case .lessThan:
			let valueToWrite = arg1(for: instruction) < arg2(for: instruction) ? 1 : 0
			memory[safe: writeAddress(for: instruction)] = valueToWrite
		case .equals:
			let valueToWrite = arg1(for: instruction) == arg2(for: instruction) ? 1 : 0
			memory[safe: writeAddress(for: instruction)] = valueToWrite
		case .adjustRelativeBase:
			relativeBase += arg1(for: instruction)
		case .halt:
			break
		}

		return nil
	}
}

private extension Array where Element == Int {

	/// This subscript will always work for positive indices
	///
	/// - When writing to an index that is out of range, the array will resize
	///   to always fit the index
	/// - When reading at an index that is out of range, it will return a default
	///   value of 1
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
