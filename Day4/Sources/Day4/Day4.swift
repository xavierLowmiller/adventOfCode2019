func possiblePasswordsPart1() -> Int {
	var count = 0

	for p in 231832...767346 {
		let s = String(p)
		if s.containsDuplicate, s.isOnlyAscending {
			count += 1
		}
	}

	return count
}

func possiblePasswordsPart2() -> Int {
	var count = 0

	for p in 231832...767346 {
		let s = String(p)
		if s.containsDuplicate, s.isOnlyAscending, s.containsPairThatIsRepeatedExactlyTwice {
			count += 1
		}
	}

	return count
}

private extension String {
	var containsDuplicate: Bool {
		for (c1, c2) in zip(self, self.dropFirst()) {
			if c1 == c2 {
				return true
			}
		}

		return false
	}

	var isOnlyAscending: Bool {
		for (c1, c2) in zip(self, self.dropFirst()) {
			if c1 > c2 {
				return false
			}
		}

		return true
	}

	var containsPairThatIsRepeatedExactlyTwice: Bool {
		let array = Array(self)
		for c in array {
			let firstOccurrence = array.firstIndex(of: c)!
			let lastOccurrence = array.lastIndex(of: c)!

			if lastOccurrence == firstOccurrence + 1 {
				return true
			}
		}

		return false
	}
}
