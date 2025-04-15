//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/15/25.
//

import SwiftUI

final class EmojiMemorizeGame: ObservableObject {
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "👹"]
    
    @Published private var model = MemorizeGame<String>(numPairOfCards: 6) { index in
        emojis[index]
    }
    
    var cards: [MemorizeGame<String>.Card] {
        model.cards
    }
    
    // MARK: Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card: card)
    }
}
