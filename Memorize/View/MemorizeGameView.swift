//
//  ContentView.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/15/25.
//

import SwiftUI

struct MemorizeGameView: View {
    
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    private let cardAspectRatio: CGFloat  = 2 / 3
    
    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
                .padding()
            
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(viewModel.themeColor)
    }
}

#Preview {
    MemorizeGameView(viewModel: EmojiMemorizeGame())
}
