func fft(of numbers: [Int], phases: UInt) -> [Int] {
	guard phases > 0 else { return numbers }

	let result: [Int] = (0..<numbers.count).map { line in

		return numbers.enumerated().reduce(0) { (result, arg1) in

			let (index, number) = arg1
			return result + number * factor(for: index, line: line)
		}
	}.map { abs($0 % 10) }

	return fft(of: result, phases: phases - 1)
}

@inline(__always)
func factor(for index: Int, line: Int) -> Int {
	switch(((index + 1) / (line + 1)) % 4) {
	case 0:
		return 0
	case 1:
		return 1
	case 2:
		return 0
	case 3:
		return -1
	default:
		fatalError()
	}
}

extension Array {
	func padded(_ times: Int) -> [Element] {
		flatMap { Array(repeating: $0, count: times) }
	}
	func repeated(_ times: Int) -> [Element] {
		[[Element]](repeating: self, count: times).flatMap { $0 }
	}
}
