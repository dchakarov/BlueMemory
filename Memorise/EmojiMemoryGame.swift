//
//  EmojiMemoryGame.swift
//  Memorise
//
//  Created by Dimitar Chakarov on 19/05/2020.
//  Copyright © 2020 Dimitar Chakarov. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["🎲", "🎯", "🎮", "🎰", "🧩", "⚽️", "🎱", "🥡", "🎹"].shuffled()
        let difficulty = Int.random(in: 3...5)
        return MemoryGame<String>(numberOfPairsOfCards: difficulty) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    var score: Int {
        game.currentScore
    }
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
    
    func restartGame() {
        game = EmojiMemoryGame.createMemoryGame()
    }
}
