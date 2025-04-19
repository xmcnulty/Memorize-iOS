//
//  ThemePicker.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/18/25.
//

import SwiftUI

struct ThemePicker: View {
    typealias Theme = EmojiMemorizeGame.Theme
    
    let onChooseTheme: (Theme) -> Void
    
    var body: some View {
        HStack {
            ForEach(Theme.allCases) { theme in
                ThemeButton(theme: theme) {
                    onChooseTheme(theme)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
