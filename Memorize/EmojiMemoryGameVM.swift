//
//  EmojiMemoryGameVM.swift
//  Memorize
//
//  Created by Macintosh on 11/08/2022.
//

import SwiftUI

class EmojiMemoryGameVM: ObservableObject {
  
  private static let emojis = ["👻","💀","☠️","😈","🤡","🤤","👽","🤑","👺","🧑🏻‍🏫","👨‍💻","🧑‍🏭","👩🏼‍💻","👨🏼‍💼","👨‍🎨","👩‍🚒","🧑‍🚀","🥷","🧟‍♀️","🧞‍♂️","🧜🏻‍♀️"]
 
  
  private static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
      EmojiMemoryGameVM.emojis[pairIndex]
    }
  }
  
   
  @Published private var model: MemoryGame<String> = createMemoryGame()
  
  
  var cards: Array<MemoryGame<String>.Card> {
    return model.cards
  }
  
  // MARK: - Intent(s)
  
  func choose(_ card: MemoryGame<String>.Card) {
    model.choose(card)
  }
}
