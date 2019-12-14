import Foundation

final class System {
	let cookbook: [String: (ingredients: [String: UInt], produces: UInt)]

	init(string: String) {
		let lines = string.components(separatedBy: "\n")

		func separate(string: String) -> (name: String, amount: UInt) {
			(string.components(separatedBy: " ")[1],
			 UInt(string.components(separatedBy: " ")[0])!)
		}

		cookbook = lines.reduce(into: [:]) { result, line in
			let pair = line
				.components(separatedBy: "=>")
				.map { $0.trimmingCharacters(in: .whitespaces)}
			let (key, amount) = separate(string: pair[1])
			let required = Dictionary(uniqueKeysWithValues: pair[0].components(separatedBy: ", ").map(separate))
			result[key] = (required, amount)
		}
	}

	func calculateOreNeeded(for fuel: UInt = 1) -> UInt {
		var cookbook = self.cookbook
		var ingredientsForFuel = cookbook.removeValue(forKey: "FUEL")!.ingredients.mapValues { $0 * fuel }

		var surplus: [String: UInt] = [:]

		while let materialToReplace = ingredientsForFuel.keys.first(where: { $0 != "ORE" }),
			var amountToReplace = ingredientsForFuel.removeValue(forKey: materialToReplace) {

				if let amountInStock = surplus[materialToReplace] {
					let diff = Int(amountToReplace) - Int(amountInStock)

					switch diff {
					case ..<0:
						surplus[materialToReplace] = amountInStock - amountToReplace
						continue
					case 0:
						surplus[materialToReplace] = nil
						continue
					default:
						amountToReplace -= amountInStock
						surplus[materialToReplace] = nil
					}
				}

				let replacement = findReplacement(for: materialToReplace, amountNeeded: amountToReplace)

				for ingredient in replacement.needed {
					ingredientsForFuel[ingredient.key, default: 0] += ingredient.value
				}

				surplus[materialToReplace, default: 0] += replacement.surplus
		}

		assert(ingredientsForFuel.count == 1)

		return ingredientsForFuel["ORE"]!
	}

	private func findReplacement(for material: String, amountNeeded: UInt) -> (needed: [String: UInt], surplus: UInt) {
		let reaction = cookbook[material]!

		let amountProvided = reaction.produces
		let factor = amountNeeded % amountProvided == 0
			? amountNeeded / amountProvided
			: amountNeeded / amountProvided + 1

		let surplus = amountProvided * factor - amountNeeded

		return (reaction.ingredients.mapValues { $0 * factor }, surplus)
	}
}
