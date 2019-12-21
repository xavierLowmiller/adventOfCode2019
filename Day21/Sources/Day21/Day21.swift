import IntCode

final class SpringDroid {
	private let computer: Computer

	init(memory: [Int]) {
		computer = Computer(memory: memory)
	}

	func findHullDamage() -> Int {
		let program = """
		NOT A J
		NOT B T
		AND T J
		NOT C T
		AND T J
		NOT C T
		OR T J
		NOT B T
		OR T J
		NOT A T
		OR T J
		AND D J
		WALK
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
