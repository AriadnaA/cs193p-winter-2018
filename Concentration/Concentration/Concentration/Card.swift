//
//  Card.swift
//  Concentration
//
//  Created by Kateryna Arapova on 24.05.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import Foundation

struct Card {
 
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUnigueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUnigueIdentifier()
    }
}
