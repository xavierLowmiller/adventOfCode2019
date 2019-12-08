struct Image {
	let layers: [String]

	init(input: String, width: Int, height: Int) {
		let pixelsPerLayer = width * height

		layers = input.chunked(into: pixelsPerLayer)
			.map { String($0) }
	}

	var checksum: Int {
		guard !layers.isEmpty, !layers[0].isEmpty else { return 0 }
		let layerWithFewestZeros = layers.min { $0.countOfZeros < $1.countOfZeros }!
		let amountOf1 = layerWithFewestZeros.filter { $0 == "1" }.count
		let amountOf2 = layerWithFewestZeros.filter { $0 == "2" }.count
		return amountOf1 * amountOf2
	}
}

private extension Sequence {
	func chunked(into size: Int) -> [[Self.Element]] {
		reduce(into: []) { result, current in

			if let last = result.last, last.count < size {
				result.append(result.removeLast() + [current])
			} else {
				result.append([current])
			}

		}
	}
}

private extension String {
	var countOfZeros: Int {
		filter { $0 == "0" }.count
	}
}
