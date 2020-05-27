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
    @State private var newDifficulty = 3
    @State private var newTheme = 0
    var themes = Theme.allCases

    var body: some View {
        VStack {
            HStack {
                Text("Current: \(emojiMemoryGame.score)")
                Text("High: \(emojiMemoryGame.highScore)")
                Spacer()
                Button("Restart Game") {
                    self.emojiMemoryGame.restartGame()
                }
            }
            .padding()
            
            Spacer()
            
            if emojiMemoryGame.isOver {
                VStack {
                    Text("GAME OVER").font(.largeTitle)
                    Text("Your Score: \(emojiMemoryGame.score)").font(.title)
                    Divider()
                    
                    Text("Fancy another game?").font(.largeTitle)
                    
                    Picker(selection: $newDifficulty, label: Text("Choose difficulty")) {
                        Text("Easy").tag(self.easyDifficulty)
                        Text("Normal").tag(self.normalDifficulty)
                        Text("Hard").tag(self.hardDifficulty)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Picker(selection: $newTheme, label: Text("Choose theme")) {
                        ForEach(0..<themes.count) { index in
                            Text(self.themes[index].rawValue).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Button("Start New Game") {
                        self.emojiMemoryGame.newGame(difficulty: self.newDifficulty, theme: self.themes[self.newTheme])
                    }
                    .font(.title)
                    .padding()
                }
            } else {
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
            
            Spacer()

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
        let fontSize = min(min(size.width, size.height) * fontScaleFactor, maxFontSize)
        return ZStack {
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
        .font(.system(size: fontSize))
    }
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    let maxFontSize: CGFloat = 100
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiMemoryGame: EmojiMemoryGame(theme: Theme.random))
    }
}
