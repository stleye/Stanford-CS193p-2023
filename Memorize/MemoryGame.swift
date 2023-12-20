//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Sebastian Tleye on 19/12/2023.
//

import Foundation

struct MemoryGame<CardContent> {

    private(set) var cards: [Card]

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }

    func choose(_ card: Card) {
        
    }

    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }

}
