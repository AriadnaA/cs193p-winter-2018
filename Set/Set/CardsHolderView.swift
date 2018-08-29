//
//  CardsHolderView.swift
//  Set
//
//  Created by Kateryna Arapova on 29.08.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import UIKit

class CardsHolderView: UIView {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
