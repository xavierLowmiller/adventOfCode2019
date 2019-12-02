func calculateFuel(for mass: Int) -> Int {
	return mass / 3 - 2
}

func calculateFuelIncludingFuelsFuel(for mass: Int) -> Int {
	var totalFuel = calculateFuel(for: mass)
	var fuelForFuel = calculateFuel(for: totalFuel)

	while fuelForFuel > 0 {
		totalFuel += fuelForFuel
		fuelForFuel = calculateFuel(for: fuelForFuel)
	}
	return totalFuel
}

func recursivelyAddUpFuel(for mass: Int, total: Int = 0) -> Int {
	let fuel = calculateFuel(for: mass)

	guard fuel > 0 else { return total }

	return recursivelyAddUpFuel(for: fuel, total: fuel + total)
}
