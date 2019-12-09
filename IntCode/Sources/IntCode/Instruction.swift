struct Instruction {
	enum AddressMode: Int {
		case position = 0
		case immediate = 1
		case relative = 2
	}

	let arg1Mode: AddressMode
	let arg2Mode: AddressMode
	let arg3Mode: AddressMode
	let opCode: Int

	init(opCode: Int) {
		self.opCode = opCode % 100
		arg1Mode = AddressMode(rawValue: opCode / 100 % 10) ?? .position
		arg2Mode = AddressMode(rawValue: opCode / 1000 % 10) ?? .position
		arg3Mode = AddressMode(rawValue: opCode / 10000 % 10) ?? .position
	}
}
