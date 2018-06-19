//
//  Card.swift
//  Concentration
//
//  Created by Kateryna Arapova on 24.05.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    
    var hashValue: Int { return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
 
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUnigueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUnigueIdentifier()
    }
}
