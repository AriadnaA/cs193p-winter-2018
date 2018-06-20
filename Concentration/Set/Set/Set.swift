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
    
    private(set) var cardsSet = [Card]()
    private(set) var notUsedCards = [Card]()
    
    private(set) var scoreCount = 0
    
    private var firstIndex: Int?
    private var secondIndex: Int?
    
    private func getStyleInfo(_ card: Card) -> (number: Int, shape: String, color: Int, style: Int) {
        let number = card.style.string.count
        let shape = String(card.style.string[card.style.string.startIndex])
        let color = card.colorType
        let style = card.styleType
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
                        // matching 3 cards
                        let cardFirst = getStyleInfo(cardsSet[first])
                        let cardSecond = getStyleInfo(cardsSet[second])
                        let cardThird = getStyleInfo(cardsSet[index])
                        var equalCount = 0
                        if (cardFirst.number, cardSecond.number) == (cardSecond.number, cardThird.number) {
                            equalCount += 1
                        }
                        if (cardFirst.shape, cardSecond.shape) == (cardSecond.shape, cardThird.shape) {
                            equalCount += 1
                        }
                        if (cardFirst.color, cardSecond.color) == (cardSecond.color, cardThird.color) {
                            equalCount += 1
                        }
                        if (cardFirst.style, cardSecond.style) == (cardSecond.style, cardThird.style) {
                            equalCount += 1
                        }
                        print(equalCount)
                        if equalCount == 3 || equalCount == 0 {
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
                            }
                            firstIndex = nil
                            secondIndex = nil
                        } else {
                            cardsSet[first].chosen = false
                            cardsSet[second].chosen = false
                            firstIndex = nil
                            secondIndex = nil
                        }
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
    
    init(cardsCount: Int, stylesSet: [(style: NSAttributedString, colorIndex: Int, styleIndex: Int)]) {
        for index in 0 ..< allCardsCount {
            let card = Card(style: stylesSet[index].style, color: stylesSet[index].colorIndex, styleIndex: stylesSet[index].styleIndex)
            if index < cardsCount {
                cardsSet.append(card)
            } else {
                notUsedCards.append(card)
            }
        }
    }
}
