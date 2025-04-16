//
//  CardView.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/15/25.
//

import SwiftUI

/// A view that visually represents a single card in the memory game.
///
/// Displays the card content when face-up, or a solid background when face-down.
/// The card is hidden when matched.
struct CardView: View {
    
    /// The card data model to be rendered.
    let card: MemorizeGame<String>.Card
    
    /// Initializes the `CardView` with a given card.
    ///
    /// - Parameter card: The card to display in the view.
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            // Face-up view
            Group {
                base.fill(.white)                    // White background for face-up card
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            // Face-down view
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .disabled(card.isMatched) // Disable interaction if card is matched
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0) // Hide matched cards
    }
}
