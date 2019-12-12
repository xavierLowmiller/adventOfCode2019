func calculateGCD(m: Int, n: Int) -> Int {
	var a: Int = 0
	var b = max(m, n)
	var r = min(m, n)

	while r != 0 {
		a = b
		b = r
		r = a % b
	}
	return b
}

func calculateLCM(a: Int, b: Int) -> Int {
	(a / calculateGCD(m: a, n: b)) * b
}

extension Array where Element == Int {
	var lcm: Int? {
		guard !isEmpty else { return nil }

		var copy = self

		while copy.count >= 2, let a = copy.popLast(), let b = copy.popLast() {
			copy.append(calculateLCM(a: a, b: b))
		}

		return copy[0]
	}
}
