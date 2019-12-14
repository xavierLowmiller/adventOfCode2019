import Foundation

struct Material: Hashable {
	var amount: UInt
	let name: String

	var isOre: Bool {
		name == "ORE"
	}
}

extension Material: CustomStringConvertible {
	init(_ string: String) {
		amount = UInt(string.split(separator: " ")[0])!
		name = String(string.split(separator: " ")[1])
	}

	var description: String {
		"\(amount) \(name)"
	}
}

struct System {
	let cookbook: [Material: [Material]]

	init(string: String) {
		let lines = string.components(separatedBy: "\n")
		cookbook = lines.reduce(into: [:]) { result, line in
			let pair = line
				.components(separatedBy: "=>")
				.map { $0.trimmingCharacters(in: .whitespaces)}
			let key = Material(pair[1])
			let values = pair[0].components(separatedBy: ", ").map(Material.init)
			result[key] = values
		}
	}

	func calculateOreNeeded() -> UInt {
		var neededForFuel = cookbook[.init("1 FUEL")]!
		var surplus: [Material] = []

		while var materialToReplace = neededForFuel.first(where: { !$0.isOre }) {
			neededForFuel = neededForFuel.filter { $0 != materialToReplace }

			// Use Surplus
			if var existingMaterial = surplus.first(where: { $0.name == materialToReplace.name }) {
				let diff = Int(materialToReplace.amount) - Int(existingMaterial.amount)
				if diff > 0 {
					materialToReplace.amount -= existingMaterial.amount
					surplus = surplus.filter { $0 != existingMaterial }
				} else if diff == 0 {
					neededForFuel = neededForFuel.filter { $0 != materialToReplace }
					surplus = surplus.filter { $0 != existingMaterial }
					continue
				} else if diff < 0 {
					neededForFuel = neededForFuel.filter { $0 != materialToReplace }
					let indexOfSurplus = surplus.firstIndex(where: { $0.name == materialToReplace.name })!
					existingMaterial.amount -= materialToReplace.amount
					surplus[indexOfSurplus] = existingMaterial
					continue
				}
			}

			let replacement = findReplacement(for: materialToReplace)
			neededForFuel += replacement.needed
			surplus.append(replacement.surplus)

			neededForFuel = neededForFuel.reduced
			surplus = surplus.reduced
		}

		assert(neededForFuel.count == 1)
		assert(neededForFuel.first!.isOre)

		return neededForFuel.first!.amount
	}

	func findReplacement(for material: Material) -> (needed: [Material], surplus: Material) {
		let reaction = cookbook.first { $0.key.name == material.name }!

		let amountNeeded = material.amount
		let amountProvided = reaction.key.amount
		let factor = amountNeeded % amountProvided == 0
			? amountNeeded / amountProvided
			: amountNeeded / amountProvided + 1

		let needed: [Material] = reaction.value.map {
			var material = $0
			material.amount *= factor
			return material
		}

		let surplus = amountProvided * factor - amountNeeded

		return (needed, Material(amount: surplus, name: material.name))
	}
}

private extension Array where Element == Material {
	/// Adds up elements of the same kind
	/// i.e.: ["1 ORE", "2 A", "3 A"] -> ["1 ORE", "5 A"]
	var reduced: [Element] {
		let names = Set(map { $0.name })
		return names.reduce(into: []) { result, name in
			let totalAmount: UInt = filter { $0.name == name }
				.map { $0.amount }
				.reduce(0, +)

			result.append(Material(amount: totalAmount, name: name))
		}
		.filter { $0.amount != 0 }
	}
}
