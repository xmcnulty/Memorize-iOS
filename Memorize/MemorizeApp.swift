//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/15/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemorizeGame()
    var body: some Scene {
        WindowGroup {
            MemorizeGameView(viewModel: game)
        }
    }
}
