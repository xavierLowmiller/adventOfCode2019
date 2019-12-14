func possiblePasswordsPart1() -> Int {
	(231832...767346)
		.map(String.init)
		.filter { $0.isOnlyAscending }
		.filter { $0.containsDuplicate }
		.count
}

func possiblePasswordsPart2() -> Int {
	(231832...767346)
		.map(String.init)
		.filter { $0.isOnlyAscending }
		.filter { $0.containsExactDuplicate }
		.count
}

extension String {
	var containsDuplicate: Bool {
		Dictionary(grouping: self, by: { $0 })
			.mapValues { $0.count }
			.values.contains { $0 >= 2 }
	}

	var containsExactDuplicate: Bool {
		Dictionary(grouping: self, by: { $0 })
			.mapValues { $0.count }
			.values.contains { $0 == 2 }
	}

	var isOnlyAscending: Bool {
		zip(self, self.dropFirst()).allSatisfy(<=)
	}
}
