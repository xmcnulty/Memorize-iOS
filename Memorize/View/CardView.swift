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
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            
            // Face-up view
            Group {
                base.fill(.white)                    // White background for face-up card
                base.strokeBorder(lineWidth: Constants.lineWidth)
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            // Face-down view
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .accessibilityElement()
        .accessibilityIdentifier("card-\(card.id)")
        .accessibilityLabel(card.debugDescription)
        .disabled(card.isMatched) // Disable interaction if card is matched
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0) // Hide matched cards
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor: CGFloat = smallest / largest
        }
    }
}
