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
