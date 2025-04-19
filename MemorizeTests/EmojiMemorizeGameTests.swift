//
//  EmojiMemorizeGameTests.swift
//  MemorizeTests
//
//  Created by Xavier McNulty on 4/16/25.
//

import XCTest
@testable import Memorize

final class EmojiMemorizeGameTests: XCTestCase {
    
    typealias Theme = EmojiMemorizeGame.Theme
    
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
    
    func testDefaultThemeIsHalloween() {
        XCTAssertEqual(emojiGame.themeColor, Theme.halloween.color)
        
        let gameContentSet = Set(
            emojiGame.cards.map { $0.content }
        )
        
        let expectedContentSet = Set(Theme.halloween.emojis)
        
        XCTAssertEqual(gameContentSet, expectedContentSet)
    }
    
    func testInitialFlagThemeGame() {
        let flagGame = EmojiMemorizeGame(theme: .flags)
        
        XCTAssertEqual(flagGame.themeColor, Theme.flags.color)
        
        let gameContentSet = Set(
            flagGame.cards.map { $0.content }
        )
        
        let expectedContentSet = Set(Theme.flags.emojis)
        
        XCTAssertEqual(gameContentSet, expectedContentSet)
    }
    
    func testInitialSportsThemeGame() {
        let sportsGame = EmojiMemorizeGame(theme: .sports)
        
        XCTAssertEqual(sportsGame.themeColor, Theme.sports.color)
        
        let gameContentSet = Set(
            sportsGame.cards.map { $0.content }
        )
        
        let expectedContentSet = Set(Theme.sports.emojis)
        
        XCTAssertEqual(gameContentSet, expectedContentSet)
    }
    
    func testChangeToDifferentTheme() {
        let oldColor = emojiGame.themeColor
        
        let oldConentSet = emojiGame.cards.map { $0.content }
        
        emojiGame.changeTheme(to: .flags)
        
        let newColor = emojiGame.themeColor
        
        let newContentSet = emojiGame.cards.map { $0.content }
        
        XCTAssertNotEqual(oldColor, newColor)
        XCTAssertNotEqual(oldConentSet, newContentSet)
    }
    
    func testChangingToCurrentThemeDoesNothing() {
        emojiGame.changeTheme(to: .sports)
        
        let chosenCard = emojiGame.cards[0]
        emojiGame.choose(chosenCard)
        
        emojiGame.changeTheme(to: .sports)
        
        XCTAssertTrue(emojiGame.cards[0].isFaceUp)
    }
    
    func testNewGameCardsAreShuffled() {
        let theme = Theme.halloween
        let game = EmojiMemorizeGame(theme: theme)
        
        let cardContents = game.cards.map { $0.content }
        var adjacentPairCount = 0

        for i in stride(from: 0, to: cardContents.count - 1, by: 1) {
            if cardContents[i] == cardContents[i + 1] {
                adjacentPairCount += 1
            }
        }

        let totalPairs = cardContents.count / 2

        XCTAssertLessThan(adjacentPairCount, totalPairs, "Too many adjacent pairs — deck may not be shuffled.")
    }
}
