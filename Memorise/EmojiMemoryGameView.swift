//
//  EmojiMemoryGameView.swift
//  Memorise
//
//  Created by Dimitar Chakarov on 19/05/2020.
//  Copyright © 2020 Dimitar Chakarov. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    @State private var difficulty = 4

    var body: some View {
        VStack {
            HStack {
                Text("Score: \(emojiMemoryGame.score)")
                Text("High: \(emojiMemoryGame.highScore)")
                Spacer()
                HStack {
                    Picker(selection: $difficulty, label: Text("")) {
                        Text("Easy").tag(self.easyDifficulty)
                        Text("Normal").tag(self.normalDifficulty)
                        Text("Hard").tag(self.hardDifficulty)
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Button("New Game") {
                    self.emojiMemoryGame.newGame(difficulty: self.difficulty, theme: Theme.random)
                }
            }
            .padding([.horizontal])
            Grid(emojiMemoryGame.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        self.emojiMemoryGame.choose(card: card)
                }
                .padding(self.cardPadding)
            }
            .padding()
            .foregroundColor(emojiMemoryGame.theme.backColour)
        }
    }
    
    let cardPadding: CGFloat = 5
    let easyDifficulty = 3
    let normalDifficulty = 6
    let hardDifficulty = 9
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(.system(size: min(size.width, size.height) * fontScaleFactor))
    }
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiMemoryGame: EmojiMemoryGame(theme: Theme.random))
    }
}
