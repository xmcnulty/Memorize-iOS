//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/15/25.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    private var indexFirstChosenCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    init(numPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        // add numPairOfCards x 2 cards to array
        for pairIndex in 0..<max(2, numPairOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { card.id == $0.id }) {
            if !cards[chosenIndex].isFaceUp  && !cards[chosenIndex].isMatched {
                
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
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        let id = UUID()
        
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "UP" : "DOWN")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
