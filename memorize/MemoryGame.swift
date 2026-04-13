//
//  MemoryGame.swift
//  memorize
//
//  Created by tingyu  on 2026/4/13.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    
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
        if let chosenIndex = index(of: card){
            if let lastIndex = lastFaceupIndex{
                if cards[lastIndex].content == cards[chosenIndex].content{
                        cards[lastIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                    
                }
                lastFaceupIndex = nil
            }else{
                for i in 0..<cards.count{
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
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: String
    }
}

