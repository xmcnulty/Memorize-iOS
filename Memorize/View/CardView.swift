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
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(alignment: .center) {
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.easeInOut(duration: 1), value: card.isMatched)
            }
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .accessibilityElement()
            .accessibilityIdentifier("card-\(card.id)")
            .accessibilityLabel(card.debugDescription)
            .disabled(card.isMatched) // Disable interaction if card is matched
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0) // Hide matched cards
    }
    
    private struct Constants {
        
        static let inset: CGFloat = 5
        
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor: CGFloat = smallest / largest
        }
        
        struct Pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
    }
}
