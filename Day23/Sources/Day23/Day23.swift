import IntCode

final class Network {
	let computers: [Computer]

	init(memory: [Int]) {
		computers = (0..<50).map { _ in
			Computer(memory: memory)
		}
	}

	func run() -> Packet {
		for (offset, computer) in computers.enumerated() {
			computer.execute(input: offset)
		}
		while true {
			for computer in computers {
				var input = [-1]
				var computer = computer
				while let packet = computer.execute(networkInput: input) {
					if packet.address == 255 {
						return packet
					}

					input = [packet.X, packet.Y, -1]
					computer = computers[packet.address]
				}
			}
		}

		fatalError()
	}
}

extension Computer {
	func execute(networkInput: [Int]) -> Packet? {
		var input = networkInput
		if let address = execute(input: &input),
			let x = execute(input: &input),
			let y = execute(input: &input) {
			return Packet(address: address, X: x, Y: y)
		} else {
			return nil
		}
	}
}

struct Packet: CustomStringConvertible {
	let address: Int
	let X: Int
	let Y: Int

	var description: String {
		"address: \(address), message: (X: \(X), Y: \(Y))"
	}
}
