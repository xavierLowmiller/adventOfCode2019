// Shamelessly stolen from https://stackoverflow.com/a/34969388/4239752
extension Array {
	var permutations: [[Element]] {
		var scratch = self // This is a scratch space for Heap's algorithm
		var result: [[Element]] = [] // This will accumulate our result

		// Heap's algorithm
		func heap(_ n: Int) {
			guard n != 1 else { return result.append(scratch) }

			for i in 0..<n - 1 {
				heap(n - 1)
				scratch.swapAt(
					n.isMultiple(of: 2) ? i : 0,
					n - 1
				)
			}
			heap(n - 1)
		}

		// Let's get started
		heap(scratch.count)

		// And return the result we built up
		return result
	}
}
