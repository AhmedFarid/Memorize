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
    GeometryReader { geometry in
      ZStack {
        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
          .padding(5)
          .opacity(0.5)
        Text(card.content)
          .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
          .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
          .font(Font.system(size: DrawingConstants.fontSize))
          .scaleEffect(scale(thisFits: geometry.size))
      }
      .cardify(isFaceUp: card.isFaceUp)
    }
  }
  
  private func scale(thisFits size : CGSize) -> CGFloat {
    min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
  }
  
  private struct DrawingConstants {
    static let fontScale: CGFloat = 0.7
    static let fontSize: CGFloat = 32
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGameVM()
    //    game.choose(game.cards.first!)
    EmojiMemoryGameView(gameViewModel: game)
      .preferredColorScheme(.dark)
    EmojiMemoryGameView(gameViewModel: game)
      .preferredColorScheme(.light)
  }
}
