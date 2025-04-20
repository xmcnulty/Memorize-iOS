//
//  ContentView.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/15/25.
//

import SwiftUI

struct MemorizeGameView: View {
    
    typealias Card = MemorizeGame<String>.Card
    
    private static let aspectRatio: CGFloat = 2 / 3
    private static let spacing: CGFloat = 4
    
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    private let cardAspectRatio: CGFloat  = aspectRatio
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.title)
                .bold()
            
            cards 
                .foregroundColor(viewModel.themeColor)
                .padding()
            
            ScoreView(score: viewModel.score)
                .animation(nil, value: viewModel.score)
            
            Divider()
            
            ThemePicker { theme in
                viewModel.changeTheme(to: theme)
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card)
                .padding(MemorizeGameView.spacing)
                .overlay(FlyingNumber(number: scoreChanged(causedBy: card)))
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.5)) {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    private func scoreChanged(causedBy card: Card) -> Int {
        return 0
    }
}

#Preview {
    MemorizeGameView(viewModel: EmojiMemorizeGame())
}
