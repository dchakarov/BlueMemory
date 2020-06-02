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
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20), clockwise: true).padding(5).opacity(0.4)
                Text(card.content)
            }
            .asCard(isFaceUp: card.isFaceUp)
            .font(.system(size: min(size.width, size.height) * fontScaleFactor))
        }
    }
    
    let fontScaleFactor: CGFloat = 0.7
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards.first!)
        return EmojiMemoryGameView(emojiMemoryGame: game)
    }
}
