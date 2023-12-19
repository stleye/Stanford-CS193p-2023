//
//  ContentView.swift
//  Memorize
//
//  Created by Sebastian Tleye on 17/12/2023.
//

import SwiftUI

let halloweenEmojis = ["🎃", "🎃", "👻", "👻", "🕷️", "🕷️", "🦇", "🦇"]
let smileyEmojis = ["😄", "😄", "😃", "😃", "😁", "😁", "😆", "😆", "😅", "😅"]
let transportEmojis = ["🚗", "🚗", "🚕", "🚕", "🚆", "🚆", "🚄", "🚄", "🚁", "🚁", "🚢", "🚢"]
let animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻"]

struct ContentView: View {

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

    @State var theme: Theme = .transport {
        didSet {
            shuffleEmojis()
        }
    }

    @State var emojis = halloweenEmojis

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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }

    func themeButton(_ theme: Theme) -> some View {
        Button(action: {
            self.theme = theme
        }, label: {
            VStack {
                theme.icon().font(.largeTitle)
                theme.title().font(.footnote)
            }
        })
    }

    func shuffleEmojis() {
        switch theme {
        case .halloween:
            self.emojis = halloweenEmojis.shuffled()
        case .smiley:
            self.emojis = smileyEmojis.shuffled()
        case .transport:
            self.emojis = transportEmojis.shuffled()
        case .animal:
            self.emojis = animalEmojis.shuffled()
        }
    }

}

struct CardView: View {
    var content: String
    @State var isFaceUp = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
