//
//  MemoryGame.swift
//  Memorize
//
//  Created by Macintosh on 11/08/2022.
//

import Foundation

struct MemoryGame<CardContent> {
  private(set) var cards: Array<Card>
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int)-> CardContent) {
    cards = Array<Card>()
    // add numberOfPairsOfCards * 2 Cards to cards array
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = createCardContent(pairIndex)
      cards.append(Card(id: pairIndex * 2, content: content))
      cards.append(Card(id: pairIndex * 2+1, content: content))
    }
  }
  
  
  func choose(_ card: Card) {
    print("hello")
  }
  
  struct Card: Identifiable {
    var id: Int
    
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
  }
}
