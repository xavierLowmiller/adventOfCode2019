func fft(of numbers: [Int], phases: UInt) -> [Int] {
	guard phases > 0 else { return numbers }

	let pattern = [0, 1, 0, -1]

	let result: [Int] = (0..<numbers.count).map { index in

		let paddedPattern = pattern.padded(index + 1)
			.repeated(numbers.count / pattern.padded(index + 1).count + 1)
			.dropFirst()

		return zip(numbers, paddedPattern).reduce(0) { (result, pair) in
			result + pair.0 * pair.1
		}
	}.map { abs($0 % 10) }

	return fft(of: result, phases: phases - 1)
}

extension Array {
	func padded(_ times: Int) -> [Element] {
		flatMap { Array(repeating: $0, count: times) }
	}
	func repeated(_ times: Int) -> [Element] {
		[[Element]](repeating: self, count: times).flatMap { $0 }
	}
}
