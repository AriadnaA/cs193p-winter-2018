//
//  ViewController.swift
//  Concentration
//
//  Created by Kateryna Arapova on 23.05.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var game: Concentration!
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var mainView: UIView!
    
    @IBAction private func newGameButton(_ sender: UIButton) {
        newGame()
        updateViewFromModel()
    }

    private(set) var flipCount = 0 {
        didSet {
            let attributes: [NSAttributedStringKey: Any] = [
                .strokeWidth: 5.0,
                .strokeColor: currentCardColor
            ]
            let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
            flipCountLabel.attributedText = attributedString
            
        }
    }
    
    private(set) var scoreCount = 0 {
        didSet {
            let attributes: [NSAttributedStringKey: Any] = [
                .strokeWidth: 5.0,
                .strokeColor: currentCardColor
            ]
            let attributedString = NSAttributedString(string: "Score: \(scoreCount)", attributes: attributes)
            scoreCountLabel.attributedText = attributedString
        }
    }
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9870811079, green: 1, blue: 0.9933142275, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 0) : currentCardColor
            }
        }
        scoreCount = game.score
        flipCount = game.flipScore
    }
    
    private func newThemeAdd(_ emoji: String, themeColor: UIColor, cardColor: UIColor) {
        allThemes.append([themeColor, cardColor, emoji])
    }
    
    private lazy var allThemes =
    [
        [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),"🦑🐡🐬🐳🐙🦐🦀🐠"],
        [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),"💐🌷🌹🌺🌸🌼🌻🌾"],
        [#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),"🍏🍎🍐🍊🍋🍉🍇🍓"],
        [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1),"🐶🐱🐭🐹🐰🦊🐻🐼"],
        [#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),"🌝🌛🌜🌚🌕🌖🌗🌘"],
        [#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),"⚽️🏀🏈⚾️🎾🏐🏉🎱"],
    ]
    
    private lazy var currentCardColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    
    private var emojiChoices = ""
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomIndex))
        }
        return emoji[card] ?? "?"
    }

    private func newGame() {
        let themeIndex = allThemes.count.arc4random
        currentCardColor = allThemes[themeIndex][1] as! UIColor
        mainView.backgroundColor = allThemes[themeIndex][0] as? UIColor
        emojiChoices = allThemes[themeIndex][2] as! String
        
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        
        updateViewFromModel()
    }
    
    override func viewDidLoad() {
        newGame()
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
