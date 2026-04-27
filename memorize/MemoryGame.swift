//
//  MemoryGame.swift
//  memorize
//
//  Created by tingyu  on 2026/4/13.
//

import Foundation

struct ThemePool<ItemContent> where ItemContent: Equatable {
    struct Theme {
        let name: String
        let color: String
        let numberOfPairs: Int
        let items: [ItemContent]
    }
    private(set) var themes: [Theme] = []
    
    mutating func addTheme(_ theme: Theme) {
        themes.append(theme)
    }
} //new

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    private(set) var score: Int = 0 //new
    init(numberOfPairsOfCards: Int,
         createCardContent: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfPairsOfCards {
            let cardContent: CardContent = createCardContent(index)
            cards.append(Card(content: cardContent, id:"\(index)a"))
            cards.append(Card(content: cardContent, id:"\(index)b"))
        }
        shuffle()
    }
    
    var lastFaceupIndex: Int?
    
    mutating func choose(_ card: Card) {
           
            if let chosenIndex = index(of: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
                
                
                if let lastIndex = lastFaceupIndex {
                    
                   
                    if cards[lastIndex].content == cards[chosenIndex].content {
                        cards[lastIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                        score += 2 // 配對成功 +2 分
                        
                    } else {
                        if cards[chosenIndex].hasBeenSeen { score -= 1 }
                        if cards[lastIndex].hasBeenSeen { score -= 1 }
                    }
                    
                    lastFaceupIndex = nil
                    
                   
                    cards[chosenIndex].hasBeenSeen = true
                    cards[lastIndex].hasBeenSeen = true
                    
                } else {
                    for i in 0..<cards.count {
                        cards[i].isFaceUp = false
                    }
                    lastFaceupIndex = chosenIndex
                }
                
          
                cards[chosenIndex].isFaceUp.toggle()
            }
            print("cards:\(cards)")
        }
    func index(of card: Card) -> Int? {
        for i in 0..<cards.count {
            if cards[i] == card {
                return i
            }
        }
        return nil
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print("shuffle cards:\(cards)")
    }
    
    struct Card: Equatable, Identifiable{
        static func == (lhs: MemoryGame<CardContent>.Card,rhs:
                        MemoryGame<CardContent>.Card) -> Bool {
            lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp &&
            lhs.isMatched == rhs.isMatched && lhs.id == rhs.id
        }
        var hasBeenSeen = false //new
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: String
    }
}

