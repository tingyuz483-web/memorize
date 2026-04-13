//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by tingyu  on 2026/4/13.
//

import Foundation

@Observable
class EmojiMemoryGame {
    
    private static var emojis =
    ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼"]

    private static func createMemoryGame() ->
        MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4,
            createCardContent:{index in
            EmojiMemoryGame.emojis[index]})
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    
    func shuffle(){
        model.shuffle()
    }
}
