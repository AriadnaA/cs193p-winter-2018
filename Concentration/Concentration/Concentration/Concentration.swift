//
//  Concentration.swift
//  Concentration
//
//  Created by Kateryna Arapova on 24.05.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneFaceUpCard: Int?
    
    var previouslySeenCards = [Card]()
    
    var score = 0
    var flipScore = 0
    
    func chooseCard(at index: Int) {
        flipScore += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score = score + 2
                } else {
                    for seenIndex in previouslySeenCards.indices {
                        if previouslySeenCards[seenIndex].identifier == cards[matchIndex].identifier || previouslySeenCards[seenIndex].identifier == cards[index].identifier{
                            score = score - 1
                            break
                        }
                    }
                    previouslySeenCards += [cards[matchIndex], cards[index]]
                }
                cards[index].isFaceUp = true
                indexOfOneFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneFaceUpCard = index
            }
        }
    }
    

    init(numberOfPairsOfCards: Int) {
        flipScore = 0
        var cardsNotRandom = [Card]()
        cards = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cardsNotRandom += [card, card]
        }
        // TODO: Shuffle the cards
        for _ in cardsNotRandom.indices {
            cardsNotRandom.sort { (_,_) in arc4random() < arc4random() }
        }
        cards = cardsNotRandom
    }
}
