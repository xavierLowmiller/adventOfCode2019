struct Instruction {
	enum AddressMode: Int {
		case position = 0
		case immediate = 1
		case relative = 2
	}

	enum Operation: Int {
		case add = 1
		case multiply = 2
		case assign = 3
		case read = 4
		case jumpIfTrue = 5
		case jumpIfFalse = 6
		case lessThan = 7
		case equals = 8
		case adjustRelativeBase = 9
		case halt = 99
	}

	let arg1Mode: AddressMode
	let arg2Mode: AddressMode
	let arg3Mode: AddressMode
	let operation: Operation

	init(opCode: Int) {
		operation = Operation(rawValue: opCode % 100)!
		arg1Mode = AddressMode(rawValue: opCode / 100 % 10) ?? .position
		arg2Mode = AddressMode(rawValue: opCode / 1000 % 10) ?? .position
		arg3Mode = AddressMode(rawValue: opCode / 10000 % 10) ?? .position
	}
}
