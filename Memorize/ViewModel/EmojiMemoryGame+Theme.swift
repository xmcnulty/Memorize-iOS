//
//  EmojiMemoryGame+Theme.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/18/25.
//

import SwiftUI

extension EmojiMemorizeGame {
    enum Theme: String, CaseIterable, Identifiable {
        case halloween = "Halloween"
        case flags = "Flags"
        case sports = "Sports"
        
        var id: String { rawValue }

        struct Properties {
            let color: Color
            let emojis: [String]
            let labelSystemImageName: String
        }
        
        private var properties: Properties {
            switch self {
            case .halloween:
                return Properties(
                    color: .orange,
                    emojis: ["👻", "🎃", "🕷️", "😈", "💀", "🧙", "👹"],
                    labelSystemImageName: "theatermasks"
                )
            case .flags:
                return Properties(
                    color: .blue,
                    emojis: ["🇦🇹", "🇪🇺", "🇨🇳", "🇩🇪", "🇮🇹", "🇯🇵", "🇰🇷", "🇺🇸"],
                    labelSystemImageName: "flag.2.crossed"
                )
            case .sports:
                return Properties(
                    color: .red,
                    emojis: ["⚽️", "🏀", "🏈", "⚾️", "🏊‍♂️", "🎾", "🏓", "⛳️", "🏃‍♂️", "🎿"],
                    labelSystemImageName: "basketball"
                )
            }
        }

        var name: String { rawValue }
        var color: Color { properties.color }
        var emojis: [String] { properties.emojis }
        var labelSystemImageName: String { properties.labelSystemImageName }
    }
}
