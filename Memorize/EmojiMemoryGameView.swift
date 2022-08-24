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
    
    VStack {
      gameBody
      deckBody
      shuffle
    }
    .padding()
  }
  
  @State private var dealt = Set<Int>()
  
  private func deal(_ card: EmojiMemoryGameVM.Card) {
    dealt.insert(card.id)
  }
  
  private func isUnDealt(_ card: EmojiMemoryGameVM.Card) -> Bool {
    return !dealt.contains(card.id)
  }
  
  var gameBody: some View {
    AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3)  { card in
      if isUnDealt(card) || (card.isMatched && !card.isFaceUp) {
        Color.clear
      }else {
        CardView(card: card)
          .padding(4)
          .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
          .onTapGesture {
            withAnimation {
              gameViewModel.choose(card)
            }
          }
      }
    }
    .foregroundColor(CardConstants.color)
  }
  
  var deckBody: some View {
    ZStack {
      ForEach(gameViewModel.cards.filter(isUnDealt)) { card in
        CardView(card: card)
          .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .opacity))
      }
    }
    .frame(width: CardConstants.unDealtWidth, height: CardConstants.unDealtHeight)
    .foregroundColor(CardConstants.color)
    .onTapGesture {
      withAnimation {
        for card in gameViewModel.cards {
          deal(card)
        }
      }
    }
  }
  
  var shuffle: some View {
    Button("Shuffle") {
      withAnimation {
        gameViewModel.shuffle()
      }
    }
  }
  
  private struct CardConstants {
    static let color = Color.blue
    static let aspectRatio: CGFloat = 2/3
    static let dealDuration: Double = 0.5
    static let totalDealDuration: Double = 2
    static let unDealtHeight: CGFloat = 90
    static let unDealtWidth = unDealtHeight * aspectRatio
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
