//
//  ScoreView.swift
//  Memorize
//
//  Created by Xavier McNulty on 4/19/25.
//

import SwiftUI

struct ScoreView: View {
    let score: Int
    
    var body: some View {
        Text("Score: \(score)")
    }
}

#Preview {
    ScoreView(score: 1)
}
