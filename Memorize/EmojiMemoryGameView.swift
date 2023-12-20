//
//  ContentView.swift
//  Memorize
//
//  Created by Sebastian Tleye on 17/12/2023.
//

import SwiftUI



struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            Spacer()
            themeButtons
        }
        .padding()
    }

    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .foregroundStyle(.purple)
    }

    var themeButtons: some View {
        HStack {
            Spacer()
            themeButton(.smiley)
            Spacer()
            themeButton(.transport)
            Spacer()
            themeButton(.animal)
            Spacer()
        }
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }

    func themeButton(_ theme: EmojiMemoryGame.Theme) -> some View {
        Button(action: {
            self.viewModel.choose(theme)
        }, label: {
            VStack {
                theme.icon().font(.largeTitle)
                theme.title().font(.footnote)
            }
        })
    }

}

struct CardView: View {

    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
