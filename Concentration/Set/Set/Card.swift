//
//  Card.swift
//  Set
//
//  Created by Kateryna Arapova on 05.06.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import Foundation

struct Card {

    var matched = false
    var removed = false
    var chosen = false
    var hidden = false
    var colorType: Int
    var styleType: Int
    var style: NSAttributedString
    
    init(style: NSAttributedString, color: Int, styleIndex: Int) {
        self.style = style
        colorType = color
        styleType = styleIndex
    }
}
