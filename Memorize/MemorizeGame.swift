//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Sebastian Tleye on 19/12/2023.
//

import Foundation

struct MemoryGame<CardContent> {

    var cards: [Card]

    func choose(card: Card) {
        
    }

    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }

}
