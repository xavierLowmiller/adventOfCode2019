struct Orbit {
	/// A mapping from a space object ID to the orbited space object ID
	/// COM)A -> [A: COM]
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

	/**
	Finds the space objects on the way to the Center of Mass (COM)

	Consider the following map of orbits:
	```
	        G - H       J - K - L
	       /           /
	 COM - B - C - D - E - F
	                \
	                 I
	```

	Calling this for the id 'L' will traverse the map backwards to the COM:
	```
	[L, K, J, E, D, C, B, COM]
	```
	*/
	private func orbitChain(for id: String, chain: [String] = []) -> [String] {
		guard let next = solarSystem[id] else { return chain }

		return orbitChain(for: next, chain: chain + [id])
	}

	/// Calculates a checksum by adding up the amount of steps it takes from
	/// an orbiting object to get to the COM
	var checksum: Int {
		solarSystem
			.map { $0.key }
			.reduce(0) { (result, id) in
				result + orbitChain(for: id).count
		}
	}

	/**
	Finds the amount of jumps required to get from `id1` to `id2`

	Consider the following map of orbits:
	```
	                          YOU
	                         /
	        G - H       J - K - L
	       /           /
	COM - B - C - D - E - F
	               \
	                I - SAN
	```


	This works by finding the first common orbiting object:

	```
	orbitChain("YOU"): [YOU, K, J, E, D, C, B, COM]
	orbitChain("SAN"): [SAN, I, D, C, B, COM]
	Common suffix:     [D, C, B, COM]
	```

	So the steps required are:

	```
	[YOU -> K -> E -> D]
	[SAN -> I -> D]
	```
	*/
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
