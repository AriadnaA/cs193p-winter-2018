//
//  Card.swift
//  Set
//
//  Created by Kateryna Arapova on 05.06.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import Foundation

struct Card {
    
    enum Shape {
        case squiggles
        case diamonds
        case ovals
        
        static var all = [Shape.squiggles, .diamonds, .ovals]
    }
    
    enum Shading {
        case solid
        case striped
        case unfilled
        
        static var all = [Shading.solid, .striped, .unfilled]

    }
    
    enum Color {
        case green
        case purple
        case red
        
        static var all = [Color.green, .purple, .red]
    }
    
    var number: Int
    var shape: Shape
    var color: Color
    var shading: Shading
    
    var matched = false
    var removed = false
    var chosen = false
    var hidden = false
    
    init(number: Int, color: Color, shading: Shading, shape: Shape) {
        self.number = number
        self.shading = shading
        self.shape = shape
        self.color = color
    }
}

