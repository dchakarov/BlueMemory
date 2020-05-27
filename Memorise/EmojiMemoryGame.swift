//
//  EmojiMemoryGame.swift
//  Memorise
//
//  Created by Dimitar Chakarov on 19/05/2020.
//  Copyright © 2020 Dimitar Chakarov. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String>
    @Published var theme: Theme
    @Published var difficulty: Int
    var highScore: Int {
        let key = "\(theme)_\(difficulty)"
        return UserDefaults.standard.integer(forKey: key)
    }
    
    init(theme: Theme, difficulty: Int = 9) {
        self.theme = theme
        self.difficulty = difficulty
        game = Self.createMemoryGame(difficulty: difficulty, theme: theme)
    }
    
    static func createMemoryGame(difficulty: Int, theme: Theme) -> MemoryGame<String> {
        let emojis = theme.cards.shuffled()
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
        if game.isOver() {
            if score > highScore {
                let key = "\(theme)_\(difficulty)"
                UserDefaults.standard.set(score, forKey: key)
            }
        }
    }
    
    func newGame(difficulty: Int, theme: Theme) {
        game = EmojiMemoryGame.createMemoryGame(difficulty: difficulty, theme: theme)
        self.theme = theme
        self.difficulty = difficulty
    }
}

enum Theme: CaseIterable {
    case sports
    case music
    case animals
    
    static var random: Self {
        Self.allCases.randomElement() ?? .sports
    }
    
    var cards: [String] {
        switch self {
        case .sports:
            return ["🎯", "⚽️", "🎱", "🏀", "🎾", "🏓", "🪀", "🏉", "🏐"]
        case .music:
            return ["🎹", "🥁", "🎸", "🎤", "🎺", "🎷", "🪕", "🎧", "🎻"]
        case .animals:
            return ["🐹", "🐝", "🦋", "🐟", "🦀", "🦕", "🦩", "🦚", "🐛"]
        }
    }
    
    var backColour: Color {
        switch self {
        case .sports:
            return .green
        case .music:
            return .orange
        case .animals:
            return .blue
        }
    }
}
