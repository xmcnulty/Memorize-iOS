//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/15/25.
//

import Foundation

struct MemorizeGame<CardContent> {
    private(set) var cards: [Card]
    
    init(numPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        // add numPairOfCards x 2 cards to array
        for pairIndex in 0..<max(2, numPairOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card{
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
