func possiblePasswordsPart1() -> Int {
	var count = 0

	for p in 231832...767346 {
		let s = String(p)
		if s.isOnlyAscending, s.containsDuplicate {
			count += 1
		}
	}

	return count
}

func possiblePasswordsPart2() -> Int {
	var count = 0

	for p in 231832...767346 {
		let s = String(p)
		if s.isOnlyAscending, s.containsDuplicateThatIsRepeatedExactlyTwice {
			count += 1
		}
	}

	return count
}

private extension String {
	var containsDuplicate: Bool {
		let numberOfCharacters = reduce(into: [:]) { result, character in
			result[character, default: 0] += 1
		}

		return numberOfCharacters.values.contains { $0 >= 2 }
	}

	var containsDuplicateThatIsRepeatedExactlyTwice: Bool {
		let numberOfCharacters = reduce(into: [:]) { result, character in
			result[character, default: 0] += 1
		}

		return numberOfCharacters.values.contains { $0 == 2 }
	}

	var isOnlyAscending: Bool {
		for (c1, c2) in zip(self, self.dropFirst()) {
			if c1 > c2 {
				return false
			}
		}

		return true
	}
}
