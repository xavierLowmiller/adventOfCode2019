struct Orbit {
	private let solarSystem: [String: SpaceObject]

	init(input: String) {
		solarSystem = parseInput(input: input)
	}

	var checksum: Int {
		solarSystem
			.map { $0.value }
			.reduce(into: 0) { (result, spaceObject) in
				result += spaceObject.orbitChain(in: solarSystem).count
		}
	}

	func jumpsRequired(between id1: String, and id2: String) -> Int {
		let object1 = solarSystem[id1]!
		let object2 = solarSystem[id2]!

		let orbitChain1 = object1.orbitChain(in: solarSystem)
		let orbitChain2 = object2.orbitChain(in: solarSystem)

		let commonSubsequence = zip(orbitChain1.reversed(), orbitChain2.reversed())
			.filter { $0.0 == $0.1 }
			.map { $0.0 }
			.reversed()

		return orbitChain1.dropLast(commonSubsequence.count).count
			+ orbitChain2.dropLast(commonSubsequence.count).count
	}
}

private struct SpaceObject {
	let id: String
	let orbitedObjectId: String

	func orbitChain(in solarSystem: [String: SpaceObject]) -> [String] {
		var chain: [String] = [id]

		var id = orbitedObjectId
		while id != "COM" {
			id = solarSystem[id]!.orbitedObjectId
			chain.append(id)
		}

		return chain
	}
}


private func parseInput(input: String) -> [String: SpaceObject] {
	input
		.split(separator: "\n")
		.reduce(into: [:]) { (result, orbitFact) in
			let id = String(orbitFact.split(separator: ")")[1])
			let orbitedObjectId = String(orbitFact.split(separator: ")")[0])

			result[id] = SpaceObject(id: id, orbitedObjectId: orbitedObjectId)
	}
}
