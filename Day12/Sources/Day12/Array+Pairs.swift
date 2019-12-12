extension Array where Element: Equatable {
	var allPairs: [(Element, Element)] {
		var result: [(Element, Element)] = []
		
		for element1 in self {
			for element2 in self.drop(while: { $0 != element1 }).dropFirst() {
				result.append((element1, element2))
			}
		}

		return result
	}
}
