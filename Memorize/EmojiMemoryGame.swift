//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sebastian Tleye on 19/12/2023.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    private static let emojisDict = [Theme.halloween: ["🎃", "👻", "🕷️", "🦇"],
                                     .smiley: ["😄", "😃", "😁", "😆", "😅"],
                                     .transport: ["🚗", "🚕", "🚆", "🚄", "🚁", "🚢"],
                                     .animal: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻"]]

    private static var theme: Theme = .halloween

    private static var emojis = emojisDict[theme]!

    @Published private var model = createEmojiMemoryGame()

    private static func createEmojiMemoryGame(_ theme: Theme = .halloween) -> MemoryGame<String> {
        self.theme = theme
        self.emojis = emojisDict[theme]!
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    func choose(_ theme: Theme) {
        self.model = EmojiMemoryGame.createEmojiMemoryGame(theme)
        self.model.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }

    enum Theme {
        case halloween
        case smiley
        case transport
        case animal

        func icon() -> some View {
            switch self {
            case .halloween:
                return Image(systemName: "house")
            case .smiley:
                return Image(systemName: "face.smiling")
            case .transport:
                return Image(systemName: "car")
            case .animal:
                return Image(systemName: "pawprint")
            }
        }

        func title() -> some View {
            switch self {
            case .halloween:
                return Text("Halloween")
            case .smiley:
                return Text("Smileys")
            case .transport:
                return Text("Transports")
            case .animal:
                return Text("Animals")
            }
        }
    }

}
