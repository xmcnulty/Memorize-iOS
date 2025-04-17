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
        XCTAssertEqual(card.label, "Face Down", "Card should start face-down")

        // C. Tap the card
        card.tap()

        // D. Assert the card is now face-up and showing its content
        XCTAssertEqual(card.label, "Face Up", "Card should be face-up after tap")
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
        XCTAssertEqual(card1.label, "Face Up", "First card should be face up")
        XCTAssertEqual(card2.label, "Face Up", "Second card should be face up")

        // Tap the third card to trigger flip back
        card3.tap()

        // Wait briefly for animation/logic to complete (adjust if needed)
        sleep(1)

        // Assert first two are now face down
        XCTAssertEqual(card1.label, "Face Down", "First card should be face down")
        XCTAssertEqual(card2.label, "Face Down", "Second card should be face down")

        // Assert third card is face up
        XCTAssertEqual(card3.label, "Face Up", "Third card should be face up")
    }

}
