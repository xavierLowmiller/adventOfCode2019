struct Orbit {
	private let solarSystem: [String: String]

	init(input: String) {
		solarSystem = input
			.split(separator: "\n")
			.reduce(into: [:]) { (result, orbitFact) in
				let id = String(orbitFact.split(separator: ")")[1])
				let orbitedObjectId = String(orbitFact.split(separator: ")")[0])

				result[id] = orbitedObjectId
		}
	}

	private func orbitChain(for id: String, chain: [String] = []) -> [String] {
		guard let next = solarSystem[id] else { return chain + [id] }

		return orbitChain(for: next, chain: chain + [id])
	}

	var checksum: Int {
		solarSystem
			.map { $0.value }
			.reduce(into: 0) { (result, id) in
				result += orbitChain(for: id).count
		}
	}

	func jumpsRequired(between id1: String, and id2: String) -> Int {
		let orbitChain1 = orbitChain(for: id1)
		let orbitChain2 = orbitChain(for: id2)

		let commonSubsequenceLength = zip(orbitChain1.reversed(), orbitChain2.reversed())
			.filter { $0.0 == $0.1 }
			.count

		return orbitChain1.count - commonSubsequenceLength - 1
			+ orbitChain2.count - commonSubsequenceLength - 1
	}
}
