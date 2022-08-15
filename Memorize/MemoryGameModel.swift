//
//  MemoryGame.swift
//  Memorize
//
//  Created by Macintosh on 11/08/2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  private(set) var cards: Array<Card>
  private var indexOfTheOneAndOnlyFaceUpCard: Int?
  
  
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int)-> CardContent) {
    cards = Array<Card>()
    // add numberOfPairsOfCards * 2 Cards to cards array
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = createCardContent(pairIndex)
      cards.append(Card(id: pairIndex * 2, content: content))
      cards.append(Card(id: pairIndex * 2+1, content: content))
    }
  }
  
  
  mutating func choose(_ card: Card) {
    if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
      if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
        if cards[chosenIndex].content == cards[potentialMatchIndex].content {
          cards[chosenIndex].isMatched = true
          cards[potentialMatchIndex].isMatched = true
        }
        indexOfTheOneAndOnlyFaceUpCard = nil
      }else {
        for index in cards.indices {
          cards[index].isFaceUp = false
        }
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
      }
      
      cards[chosenIndex].isFaceUp.toggle()
    }
    print(cards)
   }
  
  struct Card: Identifiable {
    var id: Int
    
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
  }
}
