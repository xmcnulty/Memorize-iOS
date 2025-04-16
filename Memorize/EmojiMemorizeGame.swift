//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/15/25.
//

import SwiftUI

/// A view model for the Emoji-themed memory game.
///
/// This class manages the state of the game, connects the model to the UI, and exposes user intents such as choosing cards and shuffling.
final class EmojiMemorizeGame: ObservableObject {
    
    /// The list of emoji symbols used as card content in the game.
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "👹"]
    
    /// The memory game model that contains the game logic.
    ///
    /// Initialized with 6 pairs of emoji cards.
    @Published private var model = MemorizeGame<String>(numPairOfCards: 8) { index in
        emojis[index]
    }
    
    /// The cards currently in the game, exposed to the view.
    var cards: [MemorizeGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Intents
    
    /// Shuffles the cards in the game.
    func shuffle() {
        model.shuffle()
    }
    
    /// Handles the user’s intent to choose a card.
    ///
    /// - Parameter card: The card that was selected.
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
}
