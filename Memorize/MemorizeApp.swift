//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Macintosh on 10/08/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
  private let game = EmojiMemoryGameVM()
  
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(gameViewModel: game)
        }
    }
}
