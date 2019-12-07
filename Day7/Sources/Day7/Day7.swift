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
			let amplifier = IntCode(memory: memory, input: phaseSettings[index], output)
			amplifier.execute()
			output = amplifier.output
		}

		return output
	}
}

func findMaxOutput() -> Int {
	[0, 1, 2, 3, 4].permutations
		.map {
			let assembly = IntCodeAssembly(memory: input, phaseSettings: $0)
			return assembly.execute()
	}
	.max() ?? 0
}

// Shamelessly stolen from https://stackoverflow.com/a/34969388/4239752
private extension Array {
	var permutations: [[Element]] {
		var scratch = self // This is a scratch space for Heap's algorithm
		var result: [[Element]] = [] // This will accumulate our result

		// Heap's algorithm
		func heap(_ n: Int) {
			guard n != 1 else { return result.append(scratch) }

			for i in 0..<n - 1 {
				heap(n - 1)
				scratch.swapAt(
					n.isMultiple(of: 2) ? i : 0,
					n - 1
				)
			}
			heap(n - 1)
		}

		// Let's get started
		heap(scratch.count)

		// And return the result we built up
		return result
	}
}
