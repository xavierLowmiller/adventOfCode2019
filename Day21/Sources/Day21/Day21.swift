import IntCode

final class SpringDroid {
	private let computer: Computer

	init(memory: [Int]) {
		computer = Computer(memory: memory)
	}

	func findHullDamageWalking() -> Int {
		let program = """
		NOT C J
		NOT B T
		OR T J
		NOT A T
		OR T J
		AND D J
		WALK
		"""

		return runSpringScript(program + "\n") ?? 0
	}

	func findHullDamageRunning() -> Int {
		let program = """
		NOT C J
		AND H J
		NOT B T
		OR T J
		NOT A T
		OR T J
		AND D J
		RUN
		"""

		return runSpringScript(program + "\n") ?? 0
	}

	func runSpringScript(_ program: String) -> Int? {
		// Install program
		computer.runAsciiProgram(program)
		// Execute SpringScript
		return computer.runUntilHalted().last
	}
}
