//
//  MemorizeUITests.swift
//  MemorizeUITests
//
//  Created by Xavier McNulty on 4/15/25.
//

import XCTest
import Memorize

final class MemorizeUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    @MainActor
    func testCardStartsFaceDownAndFlipsUp() throws {
        // A. Find a card by accessibilityIdentifier
        let card = app.otherElements["card-👻-0"]
        XCTAssertTrue(card.waitForExistence(timeout: 1), "The card should exist")

        // B. Assert the card is initially face-down
        XCTAssertEqual(card.label, "👻-0-face-down", "Card should start face-down")

        // C. Tap the card
        card.tap()

        // D. Assert the card is now face-up and showing its content
        XCTAssertEqual(card.label, "👻-0-face-up", "Card should be face-up after tap")
    }
    
    @MainActor
    func testTwoNonMatchingCardsFlipBackAfterThirdSelection() throws {
        let card1 = app.otherElements["card-👻-0"]
        let card2 = app.otherElements["card-🎃-0"]
        let card3 = app.otherElements["card-🕷️-0"]

        XCTAssertTrue(card1.waitForExistence(timeout: 1))
        XCTAssertTrue(card2.waitForExistence(timeout: 1))
        XCTAssertTrue(card3.waitForExistence(timeout: 1))

        // Tap the first two non-matching cards
        card1.tap()
        card2.tap()

        // Confirm both are face up
        XCTAssertEqual(card1.label, "👻-0-face-up", "First card should be face up")
        XCTAssertEqual(card2.label, "🎃-0-face-up", "Second card should be face up")

        // Tap the third card to trigger flip back
        card3.tap()

        // Wait briefly for animation/logic to complete (adjust if needed)
        sleep(1)

        // Assert first two are now face down
        XCTAssertEqual(card1.label, "👻-0-face-down", "First card should be face down")
        XCTAssertEqual(card2.label, "🎃-0-face-down", "Second card should be face down")

        // Assert third card is face up
        XCTAssertEqual(card3.label, "🕷️-0-face-up", "Third card should be face up")
    }
    
    @MainActor
    func testSwitchToFlagsTheme() throws {
        let halloweenCard = app.otherElements["card-👻-0"]
        
        let flagThemeButton = app.buttons["Flags-theme-button"]
        
        XCTAssertTrue(halloweenCard.waitForExistence(timeout: 1))
        XCTAssertTrue(flagThemeButton.waitForExistence(timeout: 1))
        
        flagThemeButton.tap()
        
        XCTAssertFalse(halloweenCard.waitForExistence(timeout: 1))
        
        let flagCard = app.otherElements["card-🇦🇹-0"]
        
        XCTAssertTrue(flagCard.waitForExistence(timeout: 1))
        
        flagCard.tap()
        
        XCTAssertEqual(flagCard.label, "🇦🇹-0-face-up")
    }
    
    @MainActor
    func testSwitchToSportsTheme() throws {
        let halloweenCard = app.otherElements["card-👻-0"]
        
        let sportsThemeButton = app.buttons["Sports-theme-button"]
        
        XCTAssertTrue(halloweenCard.waitForExistence(timeout: 1))
        XCTAssertTrue(sportsThemeButton.waitForExistence(timeout: 1))
        
        sportsThemeButton.tap()
        
        XCTAssertFalse(halloweenCard.waitForExistence(timeout: 1))
        
        let sportsCard = app.otherElements["card-⚾️-0"]
        
        XCTAssertTrue(sportsCard.waitForExistence(timeout: 1))
        
        sportsCard.tap()
        
        XCTAssertEqual(sportsCard.label, "⚾️-0-face-up")
    }
    
    @MainActor
    func testTappingButtonOfCurrentThemeDoesNothing() throws {
        let halloweenCard = app.otherElements["card-👻-0"]
        
        let halloweenThemeButton = app.buttons["Halloween-theme-button"]
        
        XCTAssertTrue(halloweenCard.waitForExistence(timeout: 1))
        XCTAssertTrue(halloweenThemeButton.waitForExistence(timeout: 1))
        
        halloweenCard.tap()
        halloweenThemeButton.tap()
        
        XCTAssertTrue(halloweenCard.waitForExistence(timeout: 1))
        XCTAssertEqual(halloweenCard.label, "👻-0-face-up", "First card should be face up")
    }
    
    @MainActor
    func testScoreUpdatesOnMatchAndMisMatch() throws {
        XCTAssertTrue(app.staticTexts["Score: 0"].exists)
        
        // Match two cards and check score updates to 2 on UI
        let card1 = app.otherElements["card-👻-0"]
        let card2 = app.otherElements["card-👻-1"]
        
        card1.tap()
        card2.tap()
        
        XCTAssertTrue(app.staticTexts["Score: 2"].exists)
        
        // Select two non matching cards and check score decrements by 1
        let card3 = app.otherElements["card-🎃-0"]
        let card4 = app.otherElements["card-🕷️-0"]
        
        card3.tap()
        card4.tap()
        
        XCTAssertTrue(app.staticTexts["Score: 1"].exists)
    }
}
