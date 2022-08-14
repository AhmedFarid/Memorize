//
//  ContentView.swift
//  Memorize
//
//  Created by Macintosh on 10/08/2022.
//

import SwiftUI

struct ContentView: View {
  let viewModel: EmojiMemoryGameVM
  
  var body: some View {
    
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
        ForEach(viewModel.cards) { card in
          CardView(card: card).aspectRatio(2/3, contentMode: .fit)
            .onTapGesture {
             viewModel.choose(card)
          }
        }
      }
    }
    .foregroundColor(.blue)
    .padding(.horizontal)
  }
}

struct CardView: View {
  let card: MemoryGame<String>.Card
  
  
  var body: some View {
    return ZStack {
      let shape = RoundedRectangle(cornerRadius: 20)
      if card.isFaceUp {
        shape.fill().foregroundColor(.white)
        shape.stroke(lineWidth: 3)
        Text(card.content).font(.largeTitle)
      }else {
        shape.fill()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGameVM()
    ContentView(viewModel: game)
      .preferredColorScheme(.dark)
    ContentView(viewModel: game)
      .preferredColorScheme(.light)
  }
}
