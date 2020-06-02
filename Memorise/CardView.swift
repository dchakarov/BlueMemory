//
//  CardView.swift
//  Memorise
//
//  Created by Dimitar Chakarov on 02/06/2020.
//  Copyright © 2020 Dimitar Chakarov. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90), clockwise: true)
                            .onAppear {
                                self.startBonusAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90), clockwise: true)
                    }
                }
                .padding(5).opacity(0.4)
                .transition(.identity)
                Text(card.content)
                    .font(.system(size: min(min(size.width, size.height) * fontScaleFactor, maxFontSize)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .asCard(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.7
    let maxFontSize: CGFloat = 100
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: MemoryGame<String>.Card(isFaceUp: true, isMatched: false, isSeen: false, content: "😜", id: 1))
    }
}
