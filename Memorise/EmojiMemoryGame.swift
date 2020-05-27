//
//  EmojiMemoryGame.swift
//  Memorise
//
//  Created by Dimitar Chakarov on 19/05/2020.
//  Copyright © 2020 Dimitar Chakarov. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["🎲", "🎯", "🎮", "🎰", "🧩", "⚽️", "🎱", "🥡", "🎹"].shuffled()
        let difficulty = Int.random(in: 3...5)
        return MemoryGame<String>(numberOfPairsOfCards: difficulty) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.currentScore
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
