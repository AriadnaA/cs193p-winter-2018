//
//  Set.swift
//  Set
//
//  Created by Kateryna Arapova on 05.06.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import Foundation

struct Set {
    
    var allCardsCount = 81
    
    var cardsSet = [Card]()
    private(set) var notUsedCards = [Card]()
    
    private(set) var scoreCount = 0
    
    private var firstIndex: Int?
    private var secondIndex: Int?
    
    private func getStyleInfo(_ card: Card) -> (number: Int, shape: Card.Shape, color: Card.Color, style: Card.Shading) {
        let number = card.number
        let shape = card.shape
        let color = card.color
        let style = card.shading
        return (number, shape, color, style)
    }
    
    
    mutating func chooseCard(at index: Int) {
        if cardsSet.indices.contains(index) {
            if cardsSet[index].chosen {
                cardsSet[index].chosen = false
                if let first = firstIndex {
                    cardsSet[first].chosen = false
                }
                if let second = secondIndex {
                    cardsSet[second].chosen = false
                }
                firstIndex = nil
                secondIndex = nil
            } else {
                if let first = firstIndex {
                    if let second = secondIndex {
//                        // matching 3 cards
//                        let cardFirst = getStyleInfo(cardsSet[first])
//                        let cardSecond = getStyleInfo(cardsSet[second])
//                        let cardThird = getStyleInfo(cardsSet[index])
//                        var equalCount = 0
//                        if (cardFirst.number, cardSecond.number) == (cardSecond.number, cardThird.number) {
//                            equalCount += 1
//                        }
//                        if (cardFirst.shape, cardSecond.shape) == (cardSecond.shape, cardThird.shape) {
//                            equalCount += 1
//                        }
//                        if (cardFirst.color, cardSecond.color) == (cardSecond.color, cardThird.color) {
//                            equalCount += 1
//                        }
//                        if (cardFirst.style, cardSecond.style) == (cardSecond.style, cardThird.style) {
//                            equalCount += 1
//                        }
//                        print(equalCount)
//                        if equalCount == 3 || equalCount == 0 {
                            scoreCount = scoreCount + 3
                            if(notUsedCards.count > 2) {
                                cardsSet[index] = notUsedCards.removeFirst()
                                cardsSet[first] = notUsedCards.removeFirst()
                                cardsSet[second] = notUsedCards.removeFirst()
                            } else {
                                print("No cards left")
                                cardsSet[index].hidden = true
                                cardsSet[first].hidden = true
                                cardsSet[second].hidden = true
                                cardsSet = cardsSet.filter({!$0.hidden})
                            }
                            firstIndex = nil
                            secondIndex = nil
//                        } else {
//                            cardsSet[first].chosen = false
//                            cardsSet[second].chosen = false
//                            firstIndex = nil
//                            secondIndex = nil
//                        }
                    } else {
                        secondIndex = index
                        cardsSet[index].chosen = true
                    }
                } else {
                    firstIndex = index
                    cardsSet[index].chosen = true
                }
            }
        }
    }
    
    mutating func add3CardsToSet() {
        cardsSet += [notUsedCards.removeFirst(), notUsedCards.removeFirst(), notUsedCards.removeFirst()]
    }
    
    init(cardsCount: Int, stylesSet: [(number: Int, color: Card.Color, shading: Card.Shading, shape: Card.Shape)]) {
        for index in 0 ..< allCardsCount {
            let card = Card(number: stylesSet[index].number, color: stylesSet[index].color, shading: stylesSet[index].shading, shape: stylesSet[index].shape)
            if index < cardsCount {
                cardsSet.append(card)
            } else {
                notUsedCards.append(card)
            }
        }
    }
}
