//
//  EmojiMemoryGameVM.swift
//  Memorize
//
//  Created by Macintosh on 11/08/2022.
//

import SwiftUI

class EmojiMemoryGameVM: ObservableObject {
  
  typealias Card = MemoryGame<String>.Card
  
  private static let emojis = ["👻","💀","☠️","😈","🤡","🤤","👽","🤑","👺","🧑🏻‍🏫","👨‍💻","🧑‍🏭","👩🏼‍💻","👨🏼‍💼","👨‍🎨","👩‍🚒","🧑‍🚀","🥷","🧟‍♀️","🧞‍♂️","🧜🏻‍♀️"]
 
  
  private static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 6) { pairIndex in
      EmojiMemoryGameVM.emojis[pairIndex]
    }
  }
  
   
  @Published private var model = createMemoryGame()
  
  
  var cards: Array<Card> {
    return model.cards
  }
  
  // MARK: - Intent(s)
  
  func choose(_ card: Card) {
    model.choose(card)
  }
}
