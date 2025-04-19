//
//  EmojiMemoryGameTheme.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/18/25.
//

import SwiftUI

extension EmojiMemorizeGame {
    enum Theme {
        case halloween
        case flags
        case sports
        
        var color: Color {
            switch self {
            case .halloween:
                return .orange
            case .flags:
                return .blue
            case .sports:
                return .red
            }
        }
        
        var emojis: [String] {
            switch self {
            case .halloween:
                return ["👻", "🎃", "🕷️", "😈", "💀", "🧙", "👹"]
            case .flags:
                return ["🇦🇹", "🇪🇺", "🇨🇳", "🇩🇪", "🇮🇹", "🇯🇵", "🇰🇷", "🇺🇸"]
            case .sports:
                return ["⚽️", "🏀", "🏈", "⚾️", "🏊‍♂️", "🎾", "🏓", "⛳️", "🏃‍♂️", "🎿"]
            }
        }
    }
}
