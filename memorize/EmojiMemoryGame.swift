//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by tingyu  on 2026/4/13.
//

import SwiftUI
import Observation
@Observable
class EmojiMemoryGame {
    typealias Theme = ThemePool<String>.Theme
    static func createThemePool() -> ThemePool<String> {
            var pool = ThemePool<String>()
            pool.addTheme(Theme(name: "賽車競技", color: "red", numberOfPairs: 8, items: ["🏎️", "🏁", "🚦", "🏆", "🏎️‍💨", "🔧", "🛞", "⛽️"]))
            pool.addTheme(Theme(name: "金融市場", color: "green", numberOfPairs: 8, items: ["📈", "💰", "🏦", "💳", "🧾", "💵", "🪙", "💹"]))
            pool.addTheme(Theme(name: "推理調查", color: "purple", numberOfPairs: 8, items: ["🔍", "🕵️‍♂️", "🧪", "🩸", "🔪", "👣", "🧬", "🔦"]))
            return pool
        }
    
    static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
            let shuffledItems = theme.items.shuffled()
            let pairs = min(theme.numberOfPairs, shuffledItems.count)
            return MemoryGame<String>(numberOfPairsOfCards: pairs, createCardContent: { index in
                shuffledItems[index]
            })
        }
    
    private var themePool: ThemePool<String>
        private(set) var currentTheme: Theme
        private var model: MemoryGame<String>
    
    
    init() {
            let pool = EmojiMemoryGame.createThemePool()
            self.themePool = pool
            let randomTheme = pool.themes.randomElement()!
            self.currentTheme = randomTheme
            self.model = EmojiMemoryGame.createMemoryGame(with: randomTheme)
        }
    
    
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    
    var score: Int {
            model.score
        }
    
    
    
    var themeColor: Color {
        switch currentTheme.color {
        case "red": return .red
        case "green": return .green
        case "purple": return .purple
        default: return .orange 
        }
    }
    
    
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    
    func shuffle(){
        model.shuffle()
    }


    func newGame() {
        currentTheme = themePool.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
}
