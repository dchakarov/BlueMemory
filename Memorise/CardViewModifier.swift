//
//  CardViewModifier.swift
//  Memorise
//
//  Created by Dimitar Chakarov on 02/06/2020.
//  Copyright © 2020 Dimitar Chakarov. All rights reserved.
//

import SwiftUI

struct CardViewModifier: AnimatableModifier {
    var isFaceUp: Bool {
        rotation < 90
    }
    var rotation: Double
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
}

extension View {
    func asCard(isFaceUp: Bool) -> some View {
        return self.modifier(CardViewModifier(isFaceUp: isFaceUp))
    }
}
