//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Macintosh on 10/08/2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var gameViewModel: EmojiMemoryGameVM
  
  var body: some View {
    
    AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3)  { card in
      if card.isMatched && !card.isFaceUp {
        Rectangle().opacity(0)
      }else {
        CardView(card: card).padding(4)
          .onTapGesture {
            gameViewModel.choose(card)
          }
      }
    }
    .foregroundColor(.blue)
    .padding(.horizontal)
  }
}

struct CardView: View {
  let card: EmojiMemoryGameVM.Card
  
  var body: some View {
    GeometryReader(content: { geometry in
      ZStack {
        let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
        if card.isFaceUp {
          shape.fill().foregroundColor(.white)
          shape.stroke(lineWidth: DrawingConstants.lineWidth)
          Text(card.content).font(font(in: geometry.size))
        } else if card.isMatched {
          shape.opacity(0)
        }else {
          shape.fill()
        }
      }
    })
  }
  
  private func font(in size: CGSize) -> Font {
    Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
  }
  
  private struct DrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.75
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGameVM()
    EmojiMemoryGameView(gameViewModel: game)
      .preferredColorScheme(.dark)
    EmojiMemoryGameView(gameViewModel: game)
      .preferredColorScheme(.light)
  }
}
