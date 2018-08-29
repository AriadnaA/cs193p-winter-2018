//
//  GridView.swift
//  Set
//
//  Created by Kateryna Arapova on 19.08.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import UIKit

class GridView: UIView {

    override func draw(_ rect: CGRect) {
        var grid = Grid(layout: Grid.Layout.aspectRatio(3/2))
//        grid.addClip()
        
        
        let button = UIButton(frame: CGRect())
        button.setTitle("test", for: UIControlState.normal)
        button.backgroundColor = UIColor.blue
        let button2 = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 120, height: 120)))
        button2.setTitle("test", for: UIControlState.normal)
        button2.backgroundColor = UIColor.green
        let button3 = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 120, height: 120)))
        button3.setTitle("test", for: UIControlState.normal)
        button3.backgroundColor = UIColor.yellow
        self.addSubview(button)
        self.addSubview(button2)
        self.addSubview(button3)
        
        grid.frame = bounds
        grid.cellCount = 3        
        setNeedsLayout()
        setNeedsDisplay()
        
    }

}
