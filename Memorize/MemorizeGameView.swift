//
//  ContentView.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/15/25.
//

import SwiftUI

struct MemorizeGameView: View {
    
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            .padding()
            
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 0)]) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }
}

#Preview {
    MemorizeGameView(viewModel: EmojiMemorizeGame())
}
