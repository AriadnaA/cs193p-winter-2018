//
//  CardsDeckView.swift
//  Set
//
//  Created by Kateryna Arapova on 29.08.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import UIKit

class CardsDeckView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        if cardsDeck.count > 0 {
            initDeck(cardsDeck)
        }
    }
    
    private var gridCardsHolder = Grid(layout: Grid.Layout.aspectRatio(2/3))
    
    private var cardsDeck = [Card]()
    
    private func setButtons(_ cards: [Card]) {
        for index in cards.indices {
            if let cellFrame = gridCardsHolder[index] {
                let card = cards[index]
                let button = CardView(frame: cellFrame.insetBy(dx: 4.0, dy: 4.0))
                button.number = card.number
                button.color = card.color
                button.shape = card.shape
                button.shading = card.shading
                
                if card.chosen {
                    button.layer.cornerRadius = 8.0
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1)
                } else {
                    button.layer.cornerRadius = 8.0
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                }
                
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                
                self.addSubview(button)
            }
        }
    }

    func initDeck(_ cards: [Card]) {
        cardsDeck = cards
        gridCardsHolder.frame = bounds
        gridCardsHolder.cellCount = cards.count
        removeSubviews()
        setButtons(cards)
    }
    
    private func removeSubviews() {
        for cardView in self.subviews {
            cardView.removeFromSuperview()
        }
    }

}
