//
//  MemorizeGameTests.swift
//  MemorizeTests
//
//  Created by Xavier McNulty on 4/16/25.
//

import XCTest
@testable import Memorize

final class MemorizeGameTests: XCTestCase {
    
    func testInitialCardCount() {
        let game = MemorizeGame<String>(numPairOfCards: 3) { "🍎\($0)" }
        XCTAssertEqual(game.cards.count, 6, "Should create 2 cards per pair")
    }

    func testShuffleChangesCardOrder() {
        var game = MemorizeGame<String>(numPairOfCards: 2) { "🍎\($0)" }
        let originalOrder = game.cards.map { $0.id }
        game.shuffle()
        
        let shuffledOrder = game.cards.map { $0.id }
        
        XCTAssertNotEqual(originalOrder, shuffledOrder, "Shuffled order should differ from original")
    }
    
    func testChooseMatchingCards() {
        var game = MemorizeGame<String>(numPairOfCards: 2) { "🍎\($0)" }
        game.shuffle()
        
        let firstIndex = game.cards.firstIndex {$0.content == "🍎0"}!
        let secondIndex = game.cards.lastIndex {$0.content == "🍎0"}!
        
        game.choose(game.cards[firstIndex])
        game.choose(game.cards[secondIndex])
        
        XCTAssertTrue(game.cards[firstIndex].isMatched)
        XCTAssertTrue(game.cards[secondIndex].isMatched)
        XCTAssertTrue(game.cards[firstIndex].isFaceUp)
        XCTAssertTrue(game.cards[secondIndex].isFaceUp)
    }
    
    func testChooseNonMatchingCards() {
        var game = MemorizeGame<String>(numPairOfCards: 2) { "🍎\($0)" }
        
        let firstIndex = game.cards.firstIndex {$0.content == "🍎0"}!
        let secondIndex = game.cards.lastIndex {$0.content == "🍎1"}!
        
        game.choose(game.cards[firstIndex])
        game.choose(game.cards[secondIndex])
        
        XCTAssertFalse(game.cards[firstIndex].isMatched)
        XCTAssertFalse(game.cards[secondIndex].isMatched)
        XCTAssertTrue(game.cards[firstIndex].isFaceUp)
        XCTAssertTrue(game.cards[secondIndex].isFaceUp)
    }
    
    func testMatchingCardsStayMatched() {
        var game = MemorizeGame<String>(numPairOfCards: 3) { "🍎\($0)" }

        let match1 = game.cards.firstIndex { $0.content == "🍎0" }!
        let match2 = game.cards.lastIndex { $0.content == "🍎0" }!
        let third = game.cards.firstIndex { $0.content == "🍎1" }!

        game.choose(game.cards[match1])
        game.choose(game.cards[match2]) // matched

        XCTAssertTrue(game.cards[match1].isMatched)
        XCTAssertTrue(game.cards[match2].isMatched)
        
        game.choose(game.cards[third])
        
        game.choose(game.cards[match1])
        game.choose(game.cards[match2]) // matched
        
        XCTAssertTrue(game.cards[match1].isMatched)
        XCTAssertTrue(game.cards[match2].isMatched)
    }
    
    func testThirdCardFlipResetsUnmatchedCards() {
        var game = MemorizeGame<String>(numPairOfCards: 3) { "🍎\($0)" }
        
        // Get three cards with different content
        let firstIndex = game.cards.firstIndex { $0.content == "🍎0" }!
        let secondIndex = game.cards.firstIndex { $0.content == "🍎1" }!
        let thirdIndex = game.cards.firstIndex { $0.content == "🍎2" }!
        
        // Choose two non-matching cards
        game.choose(game.cards[firstIndex])
        game.choose(game.cards[secondIndex])
        
        XCTAssertTrue(game.cards[firstIndex].isFaceUp)
        XCTAssertTrue(game.cards[secondIndex].isFaceUp)
        
        // Choose third card
        game.choose(game.cards[thirdIndex])
        
        // First two should now be face down if they didn't match
        XCTAssertFalse(game.cards[firstIndex].isFaceUp)
        XCTAssertFalse(game.cards[secondIndex].isFaceUp)
        
        // Third one should be face up
        XCTAssertTrue(game.cards[thirdIndex].isFaceUp)
    }
    
    func testChoosingAlreadyMatchedCardDoesNothing() {
        var game = MemorizeGame<String>(numPairOfCards: 2) { "🍎\($0)" }
        
        let firstMatchIndex = game.cards.firstIndex { $0.content == "🍎0" }!
        let secondMatchIndex = game.cards.lastIndex { $0.content == "🍎0" }!
        
        // Choose both matching cards to match them
        game.choose(game.cards[firstMatchIndex])
        game.choose(game.cards[secondMatchIndex])
        
        XCTAssertTrue(game.cards[firstMatchIndex].isMatched)
        XCTAssertTrue(game.cards[secondMatchIndex].isMatched)
        
        // Store current state
        let cardsBefore = game.cards
        
        // Try choosing the matched card again
        game.choose(game.cards[firstMatchIndex])
        
        // Assert nothing changed
        XCTAssertEqual(game.cards, cardsBefore, "Choosing a matched card should not change game state.")
    }
    
    func testChoosingAlreadyFaceUpCardDoesNothing() {
        var game = MemorizeGame<String>(numPairOfCards: 2) { "🍎\($0)" }
        
        let firstIndex = game.cards.firstIndex { $0.content == "🍎0" }!
        
        // Flip the card face up
        game.choose(game.cards[firstIndex])
        XCTAssertTrue(game.cards[firstIndex].isFaceUp, "Card should be face up after choosing it.")
        
        // Capture state before tapping again
        let cardsBefore = game.cards
        
        // Choose the same face-up card again
        game.choose(game.cards[firstIndex])
        
        // Ensure state hasn’t changed
        XCTAssertEqual(game.cards, cardsBefore, "Choosing an already face-up card should have no effect.")
    }
}
