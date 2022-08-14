//
//  ContentView.swift
//  Memorize
//
//  Created by Macintosh on 10/08/2022.
//

import SwiftUI

struct ContentView: View {
  var emojis = ["👻","💀","☠️","😈","🤡","🤤","👽","🤑","👺","🧑🏻‍🏫","👨‍💻","🧑‍🏭","👩🏼‍💻","👨🏼‍💼","👨‍🎨","👩‍🚒","🧑‍🚀","🥷","🧟‍♀️","🧞‍♂️","🧜🏻‍♀️"]
  @State var emojiCount = 6
  var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
          ForEach(emojis[0..<emojiCount], id: \.self ) { emoji in
            CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
          }
        }
      }
      .foregroundColor(.blue)
    }
    .padding(.horizontal)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.dark)
      .previewInterfaceOrientation(.portrait)
    ContentView()
      .preferredColorScheme(.light)
  }
}

struct CardView: View {
  @State var isFaceUp: Bool = false
  var content: String
  
  var body: some View {
    return ZStack {
      let shape = RoundedRectangle(cornerRadius: 20)
      if isFaceUp {
        shape.fill().foregroundColor(.white)
        shape.stroke(lineWidth: 3)
        Text(content).font(.largeTitle)
      }else {
        shape.fill()
      }
    }
    .onTapGesture {
      isFaceUp = !isFaceUp
    }
  }
}
