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
    
    lazy private var visibleCards = 12
    
    @IBOutlet weak var cardsHolder: CardsDeckView! {
        didSet{
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(deal3Cards))
            swipe.direction = [.left, .right]
            cardsHolder.addGestureRecognizer(swipe)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(selectCard))
            cardsHolder.addGestureRecognizer(tap)
            
            let scale = UIPinchGestureRecognizer(target: self, action: #selector(adjustDeckScale(byHandlingGestureRecognizedBy:)))
            cardsHolder.addGestureRecognizer(scale)
        }
    }
    
    @objc func adjustDeckScale(byHandlingGestureRecognizedBy recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .began {
            var cardsDeck = game.cardsSet
            for _ in cardsDeck.indices {
                cardsDeck.sort { (_,_) in arc4random() < arc4random() }
            }
            game.cardsSet = cardsDeck
            updateViewFromModel()
        }
    }
    
    @IBOutlet weak private var scoreLabel: UILabel!

    @IBAction private func newGameButton(_ sender: UIButton) {
        visibleCards = 12
        startGame()
    }
    
    @IBAction private func add3CardsButton(_ sender: UIButton) {
        if game.notUsedCards.count >= 3 {
            add3Cards()
            if game.notUsedCards.count < 3 {
                sender.isEnabled = false
                sender.backgroundColor = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 0.5)
            }
        }
    }
    
    private func startGame() {
        getStyles()
        game = Set(cardsCount: visibleCards, stylesSet: stylesSet)
        updateViewFromModel()
    }

    private var stylesSet = [(Int, Card.Color, Card.Shading, Card.Shape)]()
    
    private func getStyles() {
        var styles = [(Int, Card.Color, Card.Shading, Card.Shape)]()
        for number in 1...3 {
            for shape in Card.Shape.all {
                for color in Card.Color.all {
                    for style in Card.Shading.all {
                        styles.append((number, color, style, shape))
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
            scoreLabel.text = "Score: \(scoreCount)"
        }
    }
    
    private func updateViewFromModel() {
        scoreCount = game.scoreCount
        cardsHolder.initDeck(game.cardsSet)
    }

    @objc private func selectCard(sender : UITapGestureRecognizer){
        let location = sender.location(in: cardsHolder)
        if let tapCardView = cardsHolder.hitTest(location, with: nil) {
            if let tapCardIndex = cardsHolder.subviews.index(of: tapCardView) {
                game.chooseCard(at: tapCardIndex)
                updateViewFromModel()
            }
        }
    }
    
    @objc private func deal3Cards(){
        add3Cards()
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
