//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Macintosh on 10/08/2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var gameViewModel: EmojiMemoryGameVM
  @Namespace private var dealingNameSpace
  
  var body: some View {
    ZStack(alignment: .bottom){
      VStack {
        gameBody
        HStack {
          shuffle
          Spacer()
          restart
        }
        .padding(.horizontal)
      }
      deckBody
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
  
  private func dealAnimation(for card: EmojiMemoryGameVM.Card) -> Animation {
    var delay = 0.0
    if let index = gameViewModel.cards.firstIndex(where: { $0.id == card.id}) {
      delay = Double(index) * (CardConstants.totalDealDuration / Double(gameViewModel.cards.count))
    }
    return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
  }
  
  private func zIndex(of card: EmojiMemoryGameVM.Card) -> Double {
    -Double(gameViewModel.cards.firstIndex(where: {$0.id == card.id }) ?? 0)
  }
  
  var gameBody: some View {
    AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3)  { card in
      if isUnDealt(card) || (card.isMatched && !card.isFaceUp) {
        Color.clear
      }else {
        CardView(card: card)
          .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
          .padding(4)
          .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
          .zIndex(zIndex(of: card))
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
          .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
          .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
          .zIndex(zIndex(of: card))
      }
    }
    .frame(width: CardConstants.unDealtWidth, height: CardConstants.unDealtHeight)
    .foregroundColor(CardConstants.color)
    .onTapGesture {
      for card in gameViewModel.cards {
        withAnimation(dealAnimation(for: card)) {
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
  
  var restart: some View {
    Button("Restart") {
      withAnimation {
        dealt = []
        gameViewModel.restart()
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
  
  @State private var animatedBonusRemaining: Double = 0
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Group {
          if card.isConsumingBonusTime  {
            Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
              .onAppear {
                animatedBonusRemaining = card.bonusRemaining
                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                  animatedBonusRemaining = 0
                }
              }
          }else {
            Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
          }
        }
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
