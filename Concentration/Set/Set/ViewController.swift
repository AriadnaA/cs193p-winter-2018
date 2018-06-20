//
//  ViewController.swift
//  Set
//
//  Created by Kateryna Arapova on 04.06.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var game: Set!
    
    @IBOutlet private var cardButtonsCollection: [UIButton]!
    
    @IBOutlet weak private var scoreLabel: UILabel!
    
    @IBAction private func cardClick(_ sender: UIButton) {
        if let cardNumber = cardButtonsCollection.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction private func newGameButton(_ sender: UIButton) {
        cardButtonsCollection.forEach({(button) -> () in
            button.setAttributedTitle(NSAttributedString(string: ""), for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 0)
            button.layer.borderColor = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 0)
        })
        visibleCards = cardButtonsCollection.count / 2
        startGame()
    }
    
    @IBAction private func add3CardsButton(_ sender: UIButton) {
        if visibleCards < cardButtonsCollection.count && game.notUsedCards.count >= 3 {
            add3Cards()
            if visibleCards+3 > cardButtonsCollection.count || game.notUsedCards.count < 3 {
                sender.isEnabled = false
                sender.backgroundColor = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 0.5)
            }
        }
    }
    
    lazy private var visibleCards = cardButtonsCollection.count / 2
    
    private func startGame() {
        getStyles()
        game = Set(cardsCount: visibleCards, stylesSet: stylesSet)
        updateViewFromModel()
    }
    
    private var styleShape = "▲●■"
    private var styleColor = [#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
    private var styleType = ["fill", "border", "strips"]
    private var stylesSet = [(NSAttributedString, Int, Int)]()
    
    private func getStyles() {
        var number: Int
        var color: UIColor
        var shapeResult = ""
        var style: String
        var styles = [(NSAttributedString, Int, Int)]()
        for i in 1...3 {
            number = i
            for j in styleShape {
                shapeResult = ""
                let shape = String(j)
                for _ in 0 ..< number {
                    shapeResult += shape
                }
                for l in 0..<styleColor.count {
                    color = styleColor[l]
                    for k in 0..<styleType.count {
                        style = styleType[k]
                        var attributes = [NSAttributedStringKey: Any]()
                        switch style {
                        case "fill":
                            attributes = [
                                .strokeColor: color,
                                .strokeWidth: -5.0,
                                .foregroundColor: color,
                            ]
                            break
                        case "border":
                            attributes = [
                                .strokeColor: color,
                                .strokeWidth: 5.0,
                            ]
                            break
                        case "strips":
                            attributes = [
                                .strokeColor: color,
                                .strokeWidth: -5.0,
                                .foregroundColor: color.withAlphaComponent(0.2),
                            ]
                            break
                        default:
                            break
                        }
                        let attributedString = NSAttributedString(string: shapeResult, attributes: attributes)
                        styles.append((attributedString, l, k))
                    }
                }
            }
        }
        for _ in styles.indices {
            styles.sort { (_,_) in arc4random() < arc4random() }
        }
        stylesSet = styles
    }
    
    private var scoreCount = 0 {
        didSet {
            scoreLabel.text = "\(scoreCount)"
        }
    }
    
    private func updateViewFromModel() {
        scoreCount = game.scoreCount
        for index in 0..<visibleCards {
            let button = cardButtonsCollection[index]
            let card = game.cardsSet[index]
            if(card.hidden) {
                button.setAttributedTitle(NSAttributedString(string: ""), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 0)
                button.layer.borderColor = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 0)
            } else {
                if card.chosen {
                    button.layer.cornerRadius = 8.0
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1)
                } else {
                    button.layer.cornerRadius = 0
                    button.layer.borderWidth = 0
                    button.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                }
                button.backgroundColor = #colorLiteral(red: 0.9870811079, green: 1, blue: 0.9933142275, alpha: 1)
                button.setAttributedTitle(card.style, for: UIControlState.normal)
            }
        }
    }
    
    private func add3Cards(){
        visibleCards = visibleCards + 3
        game.add3CardsToSet();
        updateViewFromModel()
    }
    
    override func viewDidLoad() {
        startGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
