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
