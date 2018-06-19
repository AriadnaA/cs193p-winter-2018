//
//  Concentration.swift
//  Concentration
//
//  Created by Kateryna Arapova on 24.05.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private var previouslySeenCards = [Card]()
    
    private(set) var score = 0
    private(set) var flipScore = 0
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        flipScore += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score = score + 2
                } else {
                    for seenIndex in previouslySeenCards.indices {
                        if previouslySeenCards[seenIndex] == cards[matchIndex] || previouslySeenCards[seenIndex] == cards[index]{
                            score = score - 1
                            break
                        }
                    }
                    previouslySeenCards += [cards[matchIndex], cards[index]]
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneFaceUpCard = index
            }
        }
    }

    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you need to use at least one pair of cards")
        flipScore = 0
        var cardsNotRandom = [Card]()
        cards = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cardsNotRandom += [card, card]
        }
        for _ in cardsNotRandom.indices {
            cardsNotRandom.sort { (_,_) in arc4random() < arc4random() }
        }
        cards = cardsNotRandom
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
