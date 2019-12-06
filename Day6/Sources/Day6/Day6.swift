struct Orbit {
	private let solarSystem: [String: SpaceObject]

	init(input: String) {
		solarSystem = parseInput(input: input)
	}

	var checksum: Int {
		solarSystem
			.map { $0.value }
			.reduce(into: 0) { (result, spaceObject) in
				result += spaceObject.orbitChainLength(in: solarSystem)
		}
	}
}

struct SpaceObject {
	let id: String
	let orbitedObjectId: String

	func orbitChainLength(in solarSystem: [String: SpaceObject]) -> Int {
		var id = orbitedObjectId

		var count = 1
		while id != "COM" {
			count += 1
			id = solarSystem[id]!.orbitedObjectId
		}
		return count
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
