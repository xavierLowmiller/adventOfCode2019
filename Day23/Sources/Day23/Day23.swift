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
			var input = [-1]
			for computer in computers {
				var computer = computer
				while let packet = computer.execute(networkInput: input) {
					if packet.address == 255 {
						return packet
					}

					input = [packet.X, packet.Y, -1]
					computer = computers[packet.address]
				}
				input = [-1]
			}
		}

		fatalError()
	}

	func runWithNat() -> Packet {
		for (offset, computer) in computers.enumerated() {
			computer.execute(input: offset)
		}
		var natPacket: Packet?
		var lastYSent = 0
		var packetsSent = 0
		var input = [-1]
		while true {
			for computer in computers {
				var computer = computer
				while let packet = computer.execute(networkInput: input) {
					packetsSent += 1
					if packet.address == 255 {
						natPacket = packet
					} else {
						input = [packet.X, packet.Y, -1]
						computer = computers[packet.address]
					}
				}
				input = [-1]
			}
			if packetsSent == 0, let natPacket = natPacket {
				input = [natPacket.X, natPacket.Y]
				if lastYSent == natPacket.Y {
					return natPacket
				} else {
					lastYSent = natPacket.Y
				}
			} else {
				packetsSent = 0
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

struct Packet: CustomStringConvertible, Equatable {
	let address: Int
	let X: Int
	let Y: Int

	var description: String {
		"address: \(address), message: (X: \(X), Y: \(Y))"
	}
}
