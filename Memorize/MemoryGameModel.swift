//
//  MemoryGame.swift
//  Memorize
//
//  Created by Macintosh on 11/08/2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  private(set) var cards: Array<Card>
  
  private var indexOfTheOneAndOnlyFaceUpCard: Int? {
    get { cards.indices.filter ({cards[$0].isFaceUp}).oneAndOnly }
    set { cards.indices.forEach{cards[$0].isFaceUp = ($0 == newValue)} }
  }

  init(numberOfPairsOfCards: Int, createCardContent: (Int)-> CardContent) {
    cards = []
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
        cards[chosenIndex].isFaceUp = true
      }else {
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
      }
    }
  }
  
  struct Card: Identifiable {
    var id: Int
    
    var isFaceUp = false
    var isMatched = false
    var content: CardContent
  }
}


extension Array {
  var oneAndOnly: Element? {
    if count == 1 {
      return first
    }else {
      return nil
    }
  }
}
