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
    
    var body: some View {
        VStack {
            HStack {
                Text("Score: \(emojiMemoryGame.score)")
                Spacer()
                Button("New Game") {
                    self.emojiMemoryGame.restartGame()
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
            .foregroundColor(.orange)
        }
    }
    
    let cardPadding: CGFloat = 5
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
        EmojiMemoryGameView(emojiMemoryGame: EmojiMemoryGame())
    }
}
