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
    private var theme: Theme
    
    /// The memory game model that contains the game logic.
    ///
    /// Initialized with 6 pairs of emoji cards.
    @Published private var model: MemorizeGame<String>
    
    /// The cards currently in the game, exposed to the view.
    var cards: [MemorizeGame<String>.Card] {
        model.cards
    }
    
    var themeColor: Color {
        theme.color
    }
    
    init(theme: Theme = .halloween) {
        self.theme = theme
        
        model = EmojiMemorizeGame.createGame(with: theme)
        
        model.shuffle()
    }
    
    private static func createGame(with theme: Theme) -> MemorizeGame<String> {
        return MemorizeGame<String>(numPairOfCards: theme.emojis.count) { index in
            theme.emojis[index]
        }
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
    
    func changeTheme(to newTheme: Theme) {
        guard newTheme != theme else { return }
        theme = newTheme
        model = EmojiMemorizeGame.createGame(with: theme)
        
        model.shuffle()
    }

}
