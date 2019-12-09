public struct EncodedImage {
	public let width: Int
	public let height: Int
	public let layers: [[Character]]

	public init(input: String, width: Int, height: Int) {
		self.width = width
		self.height = height

		let pixelsPerLayer = width * height
		layers = input.chunked(into: pixelsPerLayer)
	}

	var checksum: Int {
		guard !layers.isEmpty, !layers[0].isEmpty else { return 0 }

		let layerWithFewestZeros = layers
			.min { $0.filter { $0 == "0" }.count < $1.filter { $0 == "0" }.count }!
		let amountOf1 = layerWithFewestZeros.filter { $0 == "1" }.count
		let amountOf2 = layerWithFewestZeros.filter { $0 == "2" }.count
		return amountOf1 * amountOf2
	}

	var decoded: [String] {
		(0..<width * height)
			.reduce(into: "") { result, index in
				let layeredPixels = layers.map { $0[index] }
				result.append(layeredPixels.first { $0 != "2" } ?? "0")
			}
			.chunked(into: width).map { String($0) }
	}
}
