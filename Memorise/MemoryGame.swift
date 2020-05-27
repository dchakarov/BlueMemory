//
//  MemoryGame.swift
//  Memorise
//
//  Created by Dimitar Chakarov on 19/05/2020.
//  Copyright © 2020 Dimitar Chakarov. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    var currentScore = 0
    var cards: Array<Card>
    var indexOfFaceUpCard: Int? {
        get {
            let faceUpIndices = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpIndices.count == 1 ? faceUpIndices.first : nil
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    func index(of card: Card) -> Int? {
        cards.firstIndex { $0.id == card.id }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = index(of: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    currentScore += 2
                } else {
                    if cards[chosenIndex].isSeen {
                        currentScore -= 1
                    }
                    if cards[potentialMatchIndex].isSeen {
                        currentScore -= 1
                    }
                }
                cards[chosenIndex].isSeen = true
                cards[potentialMatchIndex].isSeen = true
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfFaceUpCard = chosenIndex
            }
        }
    }
    
    var isOver: Bool {
        cards.filter { $0.isMatched }.count == cards.count
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var isSeen = false
        var content: CardContent
        var id: Int
    }
}
