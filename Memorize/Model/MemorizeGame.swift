//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/15/25.
//

import Foundation

/// A generic memory matching game model that manages game state and card logic.
struct MemorizeGame<CardContent> where CardContent: Equatable {
    
    /// The array of all cards in the game. Each pair of cards shares the same content.
    private(set) var cards: [Card]
    
    /// The index of the currently face-up card, if exactly one card is face-up.
    /// Used to determine if a match should be checked.
    private var indexFirstChosenCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    /// Initializes a new memory game with a given number of card pairs.
    ///
    /// - Parameters:
    ///   - numPairOfCards: The number of pairs of cards to create (minimum of 2 pairs).
    ///   - cardContentFactory: A closure that provides the content for each card pair based on its index.
    /// - Precondition: `numPairOfCards >= 2`. The game requires at least two pairs to function properly.
    init(numPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        precondition(numPairOfCards >= 2, "Game requires at least two pairs of cards.")
        cards = []
        
        // Ensure at least 2 pairs exist.
        for pairIndex in 0..<numPairOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(content)-0"))
            cards.append(Card(content: content, id: "\(content)-1)"))
        }
    }
    
    /// Handles user intent to choose a card.
    /// If a card is selected and matches the only face-up card, they become matched.
    /// Otherwise, this card becomes the only face-up card.
    ///
    /// - Parameter card: The card the user tapped.
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { card.id == $0.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                
                if let potentialMatchIndex = indexFirstChosenCard {
                    if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                    }
                } else {
                    indexFirstChosenCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    /// Shuffles the cards in the game.
    mutating func shuffle() {
        cards.shuffle()
    }
    
    /// A card in the memory game, representing a single face-down or face-up piece of content.
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        /// Whether the card is currently face up.
        var isFaceUp = false
        
        /// Whether the card has been successfully matched.
        var isMatched = false
        
        /// The content of the card. Must be equatable to compare for matches.
        let content: CardContent
        
        /// Unique identifier for the card.
        let id: String
        
        /// Debug-friendly string representing the card's state.
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "UP" : "DOWN")"
        }
    }
}

extension Array {
    /// Returns the only element in the array if it contains exactly one element; otherwise, returns `nil`.
    var only: Element? {
        count == 1 ? first : nil
    }
}
