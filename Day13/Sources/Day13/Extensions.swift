import IntCode

extension Computer: Sequence, IteratorProtocol {
	public func next() -> Int? {
		execute()
	}
}

extension Sequence {
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
