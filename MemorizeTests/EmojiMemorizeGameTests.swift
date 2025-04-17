//
//  EmojiMemorizeGameTests.swift
//  MemorizeTests
//
//  Created by Xavier McNulty on 4/16/25.
//

import XCTest
@testable import Memorize

final class EmojiMemorizeGameTests: XCTestCase {
    
    var emojiGame: EmojiMemorizeGame!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        emojiGame = EmojiMemorizeGame()
        
        super.setUp()
    }

    func testChosenCardFlipsUp() {
        let chosenCard = emojiGame.cards[0]
        
        XCTAssertFalse(emojiGame.cards[0].isFaceUp)
        
        emojiGame.choose(chosenCard)
        
        XCTAssertTrue(emojiGame.cards[0].isFaceUp)
    }
    
    func testShuffleChangesOrder() {
        let beforeShuffleOrder = emojiGame.cards.map { $0.id }
        emojiGame.shuffle()
        let afterShuffleOrder = emojiGame.cards.map { $0.id }
        
        XCTAssertNotEqual(beforeShuffleOrder, afterShuffleOrder)

    }
}
