struct IntCodeAssembly {
	private let memory: [Int]
	private let phaseSettings: [Int]

	init(memory: [Int], phaseSettings: [Int]) {
		assert(phaseSettings.count == 5)
		self.memory = memory
		self.phaseSettings = phaseSettings
	}

	func execute() -> Int {
		var output = 0

		for index in 0..<5 {
			let amplifier = IntCode(memory: memory)
			amplifier.execute(input: phaseSettings[index], output)
			output = amplifier.output
		}

		return output
	}

	static func findMaxOutput() -> Int {
		[0, 1, 2, 3, 4].permutations
			.map {
				let assembly = IntCodeAssembly(memory: input, phaseSettings: $0)
				return assembly.execute()
		}
		.max() ?? 0
	}
}
