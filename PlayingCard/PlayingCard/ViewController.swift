//
//  ViewController.swift
//  PlayingCard
//
//  Created by Kateryna Arapova on 02.07.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    @IBOutlet weak var playindCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playindCardView.addGestureRecognizer(swipe)
            
            let pinch = UIPinchGestureRecognizer(target: playindCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:)))
            playindCardView.addGestureRecognizer(pinch)
        }
    }
    
    @objc func nextCard() {
        if let card = deck.draw() {
            playindCardView.rank = card.rank.order
            playindCardView.suit = card.suit.rawValue
        }
    }
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        playindCardView.isFaceUp = !playindCardView.isFaceUp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

}

