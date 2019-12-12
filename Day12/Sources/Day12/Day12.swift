import Foundation

struct Vector: Equatable {
	var x: Int
	var y: Int
	var z: Int

	static let zero: Vector = Vector(x: 0, y: 0, z: 0)

	var absSum: Int {
		abs(x) + abs(y) + abs(z)
	}
}

struct Moon: Equatable, Identifiable, CustomStringConvertible {
	let id = UUID()
	var position: Vector
	var velocity: Vector = .zero

	var energy: Int {
		position.absSum * velocity.absSum
	}

	static func == (lhs: Moon, rhs: Moon) -> Bool {
		lhs.position == rhs.position && lhs.velocity == rhs.velocity
	}

	var description: String {
		"p: (\(position.x), \(position.y), \(position.z)), v: (\(velocity.x), \(velocity.y), \(velocity.z))"
	}
}

final class System {
	var moons: [Moon]

	var energy: Int {
		moons.map { $0.energy }.reduce(0, +)
	}

	init(moons: [Moon]) {
		self.moons = moons
	}

	func step() {
		updateVelocities()
		updatePositions()
	}

	func updateVelocities() {
		for (moon1, moon2) in moons.allPairs {

			guard let index1 = moons.firstIndex(where: { $0.id == moon1.id })
				else { fatalError() }
			guard let index2 = moons.firstIndex(where: { $0.id == moon2.id })
				else { fatalError() }

			var (moon1, moon2) = (moons[index1], moons[index2])

			if moon1.position.x > moon2.position.x {
				moon1.velocity.x -= 1
				moon2.velocity.x += 1
			} else if moon1.position.x < moon2.position.x {
				moon1.velocity.x += 1
				moon2.velocity.x -= 1
			}

			if moon1.position.y > moon2.position.y {
				moon1.velocity.y -= 1
				moon2.velocity.y += 1
			} else if moon1.position.y < moon2.position.y {
				moon1.velocity.y += 1
				moon2.velocity.y -= 1
			}

			if moon1.position.z > moon2.position.z {
				moon1.velocity.z -= 1
				moon2.velocity.z += 1
			} else if moon1.position.z < moon2.position.z {
				moon1.velocity.z += 1
				moon2.velocity.z -= 1
			}

			moons[index1] = moon1
			moons[index2] = moon2
		}
	}

	func updatePositions() {
		moons = moons.map {
			var moon = $0
			moon.position.x += moon.velocity.x
			moon.position.y += moon.velocity.y
			moon.position.z += moon.velocity.z
			return moon
		}
	}
}

extension Vector {
	var tuple: (Int, Int, Int) {
		(x, y, z)
	}

	init(tuple: (Int, Int, Int)) {
		self.init(
			x: tuple.0,
			y: tuple.1,
			z: tuple.2
		)
	}
}

extension Moon {
	init(positionT: (Int, Int, Int), velocityT: (Int, Int, Int) = (0, 0, 0)) {
		self.init(position: Vector(tuple: positionT),
							velocity: Vector(tuple: velocityT))
	}
}
