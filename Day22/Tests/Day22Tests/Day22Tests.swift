import XCTest
@testable import Day22

final class Day22Tests: XCTestCase {
	func testDealIntoNewStack() {
		// Given
		let deck = CardDeck(amount: 10)
		let expected = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

		// When
		deck.dealIntoNewStack()

		// Then
		XCTAssertEqual(deck.cards, expected)
	}

	func testCutPositive() {
		// Given
		let deck = CardDeck(amount: 10)
		let expected = [3, 4, 5, 6, 7, 8, 9, 0, 1, 2]

		// When
		deck.cut(3)

		// Then
		XCTAssertEqual(deck.cards, expected)
	}

	func testCutNegative() {
		// Given
		let deck = CardDeck(amount: 10)
		let expected = [6, 7, 8, 9, 0, 1, 2, 3, 4, 5]

		// When
		deck.cut(-4)

		// Then
		XCTAssertEqual(deck.cards, expected)
	}

	func testDealWithIncrement() {
		// Given
		let deck = CardDeck(amount: 10)
		let expected = [0, 7, 4, 1, 8, 5, 2, 9, 6, 3]

		// When
		deck.dealWithIncrement(3)

		// Then
		XCTAssertEqual(deck.cards, expected)
	}

	func testPerformCommands1() {
		// Given
		let deck = CardDeck(amount: 10)
		let commands = """
		deal with increment 7
		deal into new stack
		deal into new stack
		""".split(separator: "\n")
		let expected = [0, 3, 6, 9, 2, 5, 8, 1, 4, 7]

		// When
		deck.performCommands(commands)

		// Then
		XCTAssertEqual(deck.cards, expected)
	}


	func testPerformCommands2() {
		// Given
		let deck = CardDeck(amount: 10)
		let commands = """
		cut 6
		deal with increment 7
		deal into new stack
		""".split(separator: "\n")
		let expected = [3, 0, 7, 4, 1, 8, 5, 2, 9, 6]

		// When
		deck.performCommands(commands)

		// Then
		XCTAssertEqual(deck.cards, expected)
	}

	func testPerformCommands3() {
		// Given
		let deck = CardDeck(amount: 10)
		let commands = """
		deal with increment 7
		deal with increment 9
		cut -2
		""".split(separator: "\n")
		let expected = [6, 3, 0, 7, 4, 1, 8, 5, 2, 9]

		// When
		deck.performCommands(commands)

		// Then
		XCTAssertEqual(deck.cards, expected)
	}

	func testPerformCommands4() {
		// Given
		let deck = CardDeck(amount: 10)
		let commands = """
		deal into new stack
		cut -2
		deal with increment 7
		cut 8
		cut -4
		deal with increment 7
		cut 3
		deal with increment 9
		deal with increment 3
		cut -1
		""".split(separator: "\n")
		let expected = [9, 2, 5, 8, 1, 4, 7, 0, 3, 6]

		// When
		deck.performCommands(commands)

		// Then
		XCTAssertEqual(deck.cards, expected)
	}

	func testDay22SolutionPart1() {
		let deck = CardDeck(amount: 10007)
		deck.performCommands(input.split(separator: "\n"))

		print("Solution to day 22 part 1:", deck.cards.firstIndex(of: 2019)!)
	}
}
