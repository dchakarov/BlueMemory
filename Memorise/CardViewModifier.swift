//
//  CardViewModifier.swift
//  Memorise
//
//  Created by Dimitar Chakarov on 02/06/2020.
//  Copyright © 2020 Dimitar Chakarov. All rights reserved.
//

import SwiftUI

struct CardViewModifier: ViewModifier {
    var isFaceUp: Bool
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3

    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }
}

extension View {
    func asCard(isFaceUp: Bool) -> some View {
        return self.modifier(CardViewModifier(isFaceUp: isFaceUp))
    }
}
