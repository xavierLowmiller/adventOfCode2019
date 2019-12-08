import IntCode

struct IntCodeAssembly {
	private let memory: [Int]
	private let phaseSettings: [Int]

	init(memory: [Int], phaseSettings: [Int]) {
		assert(phaseSettings.count == 5)
		self.memory = memory
		self.phaseSettings = phaseSettings
	}

	func execute() -> Int {
		guard
			let output0 = Computer(memory: memory).execute(input: phaseSettings[0], 0),
			let output1 = Computer(memory: memory).execute(input: phaseSettings[1], output0),
			let output2 = Computer(memory: memory).execute(input: phaseSettings[2], output1),
			let output3 = Computer(memory: memory).execute(input: phaseSettings[3], output2),
			let output4 = Computer(memory: memory).execute(input: phaseSettings[4], output3)
			else { return -1 }

		return output4
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
	private let amplifiers: (Computer, Computer, Computer, Computer, Computer)
	private let phaseSettings: [Int]

	private var finalOutput: Int?

	init(memory: [Int], phaseSettings: [Int]) {
		assert(phaseSettings.count == 5)
		self.phaseSettings = phaseSettings

		amplifiers = (
			Computer(memory: memory),
			Computer(memory: memory),
			Computer(memory: memory),
			Computer(memory: memory),
			Computer(memory: memory)
		)
	}

	func execute() -> Int {
		var lastOutput = 0

		guard
			let output0 = amplifiers.0.execute(input: phaseSettings[0], 0),
			let output1 = amplifiers.1.execute(input: phaseSettings[1], output0),
			let output2 = amplifiers.2.execute(input: phaseSettings[2], output1),
			let output3 = amplifiers.3.execute(input: phaseSettings[3], output2),
			let output4 = amplifiers.4.execute(input: phaseSettings[4], output3)
			else { return -1 }

		lastOutput = output4

		while true {
			guard
				let output0 = amplifiers.0.execute(input: lastOutput),
				let output1 = amplifiers.1.execute(input: output0),
				let output2 = amplifiers.2.execute(input: output1),
				let output3 = amplifiers.3.execute(input: output2),
				let output4 = amplifiers.4.execute(input: output3)
				else { break }
			lastOutput = output4
		}

		return lastOutput
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
