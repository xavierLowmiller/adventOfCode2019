struct IntCodeAssembly {
	private let memory: [Int]
	private let phaseSettings: [Int]

	init(memory: [Int], phaseSettings: [Int]) {
		assert(phaseSettings.count == 5)
		self.memory = memory
		self.phaseSettings = phaseSettings
	}

	func execute() -> Int {
		let amplifiers = (
			IntCode(memory: memory),
			IntCode(memory: memory),
			IntCode(memory: memory),
			IntCode(memory: memory),
			IntCode(memory: memory)
		)
		amplifiers.0.outputSignal = { output in
			amplifiers.1.execute(input: self.phaseSettings[1], output)
		}
		amplifiers.1.outputSignal = { output in
			amplifiers.2.execute(input: self.phaseSettings[2], output)
		}
		amplifiers.2.outputSignal = { output in
			amplifiers.3.execute(input: self.phaseSettings[3], output)
		}
		amplifiers.3.outputSignal = { output in
			amplifiers.4.execute(input: self.phaseSettings[4], output)
		}

		var output: Int?
		amplifiers.4.outputSignal = {
			output = $0
		}

		amplifiers.0.execute(input: phaseSettings[0], 0)


		return output!
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

final class FeedbackLoopAssembly {
	private let amplifiers: (IntCode, IntCode, IntCode, IntCode, IntCode)
	private let phaseSettings: [Int]

	private var finalOutput: Int?

	init(memory: [Int], phaseSettings: [Int]) {
		assert(phaseSettings.count == 5)
		self.phaseSettings = phaseSettings

		amplifiers = (
			IntCode(memory: memory),
			IntCode(memory: memory),
			IntCode(memory: memory),
			IntCode(memory: memory),
			IntCode(memory: memory)
		)
	}

	func execute() -> Int {
		amplifiers.0.execute(input: phaseSettings[0], 0)
		amplifiers.1.execute(input: phaseSettings[1], amplifiers.0.output)
		amplifiers.2.execute(input: phaseSettings[2], amplifiers.1.output)
		amplifiers.3.execute(input: phaseSettings[3], amplifiers.2.output)
		amplifiers.4.execute(input: phaseSettings[4], amplifiers.3.output)

		amplifiers.0.outputSignal = { output in
			self.amplifiers.1.execute(input: output)
		}
		amplifiers.1.outputSignal = { output in
			self.amplifiers.2.execute(input: output)
		}
		amplifiers.2.outputSignal = { output in
			self.amplifiers.3.execute(input: output)
		}
		amplifiers.3.outputSignal = { output in
			self.amplifiers.4.execute(input: output)
		}
		amplifiers.4.outputSignal = { output in
			self.finalOutput = output
			self.amplifiers.0.execute(input: output)
		}

		amplifiers.0.execute(input: amplifiers.4.output)

		return finalOutput!
	}

	static func findMaxOutput() -> Int {
		[5, 6, 7, 8, 9].permutations
			.map {
				let assembly = FeedbackLoopAssembly(memory: input, phaseSettings: $0)
				return assembly.execute()
		}
		.max() ?? 0
	}
}
