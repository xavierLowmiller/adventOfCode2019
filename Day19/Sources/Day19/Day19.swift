import IntCode

struct Point: Hashable {
	let x: Int
	let y: Int
}

final class TractorBeam {
	private let memory: [Int]

	init(memory: [Int]) {
		self.memory = memory
	}

	func pointsAffectedByTractorBeam(in range: Int) -> [Point: Int] {

		var result: [Point: Int] = [:]

		for x in 0..<range {
			for y in 0..<range {
				let computer = Computer(memory: memory)
				let answer = computer.execute(input: x, y)
				result[Point(x: x, y: y)] = answer
			}
		}

		return result
	}
}
