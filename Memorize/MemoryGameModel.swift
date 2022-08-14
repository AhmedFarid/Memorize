//
//  MemoryGame.swift
//  Memorize
//
//  Created by Macintosh on 11/08/2022.
//

import Foundation

struct MemoryGame<CardContant> {
  var cards: Array<Card>
  
  func choose(_ card: Card) {
    
  }
  
  struct Card {
    var isFaceUp: Bool
    var isMatched: Bool
    var content: CardContant
  }
}
