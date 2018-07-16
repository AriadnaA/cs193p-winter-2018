//
//  Card.swift
//  Set
//
//  Created by Kateryna Arapova on 05.06.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import Foundation

struct Card {
    
    enum Shape: String {
        case triangle = "▲"
        case circle = "●"
        case square = "■"
        
        static var all = [Shape.triangle, .circle, .square]
    }
    
    enum StyleType {
        case fill
        case border
        case strips
        
        static var all = [StyleType.fill, .border, .strips]
        
        var strokeWidth: Double {
            switch self {
            case .fill, .strips:
                return -5.0
            case .border:
                return 5.0
            }
        }
    }
    
    enum Color {
        case green
        case blue
        case red
        
        static var all = [Color.green, .blue, .red]
    }
    
    var shape: Shape
    var colorType: Color
    var styleType: StyleType
    var style: NSAttributedString
    
    var matched = false
    var removed = false
    var chosen = false
    var hidden = false
    
    init(style: NSAttributedString, color: Color, styleType: StyleType, shape: Shape) {
        self.style = style
        self.styleType = styleType
        self.shape = shape
        colorType = color
    }
}

