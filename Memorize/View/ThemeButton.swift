//
//  ThemeButton.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/18/25.
//

import SwiftUI

struct ThemeButton: View {
    typealias Theme = EmojiMemorizeGame.Theme
    
    let theme: Theme
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: theme.labelSystemImageName)
                    .font(.title)
                Text(theme.name)
            }
        }
        .accessibilityElement()
        .accessibilityIdentifier("\(theme.name)-theme-button")
        .accessibilityAddTraits(.isButton)
    }
}
