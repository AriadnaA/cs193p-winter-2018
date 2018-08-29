//
//  CardView.swift
//  Set
//
//  Created by Kateryna Arapova on 26.08.2018.
//  Copyright © 2018 Kateryna Arapova. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    lazy private var grid = Grid(layout: Grid.Layout.dimensions(rowCount: 1, columnCount: 3), frame: bounds)
    
    var shape = Card.Shape.ovals
    var shading = Card.Shading.solid
    var number = 1
    var color = Card.Color.purple
    
    private func drawShapes() {
        grid.cellCount = number
        grid.aspectRatio = 2/1
        
        for cellGridIndex in 0..<number {
            if let cellRectInGrid = grid[cellGridIndex] {
                let shapePath = getShapePath(in: cellRectInGrid)
                
                ShapeColor.setStroke()
                ShapeColor.setFill()
                
                switch shading {
                case .unfilled:
                    shapePath.stroke()
                case .solid:
                    shapePath.fill()
                case .striped:
                    drawStripedShading(in: cellRectInGrid, for: shapePath)
                }
            }
        }
        
    }
    
    private func getShapePath(in rect: CGRect) -> UIBezierPath {
        switch shape {
        case .ovals:
            return UIBezierPath(roundedRect: rect.insetBy(dx: SizeRatio.cellSpacing * rect.width, dy: SizeRatio.cellSpacing * rect.height), cornerRadius: cornerRadius)
        case .diamonds:
            return drawShapeDiamonds(in: rect)
        case .squiggles:
            return drawShapeSquiggles(in: rect)
        }
    }
    
    private func drawShapeDiamonds(in rect: CGRect) -> UIBezierPath {
        let shapePath = UIBezierPath()
        let scaleX = rect.width * SizeRatio.cellSpacing
        let scaleY = rect.height * SizeRatio.cellSpacing
        
        shapePath.move(to: CGPoint(x: rect.midX, y: rect.minY + scaleY))
        shapePath.addLine(to: CGPoint(x: rect.maxX - scaleX, y: rect.midY))
        shapePath.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - scaleY))
        shapePath.addLine(to: CGPoint(x: rect.minX + scaleX, y: rect.midY))
        shapePath.close()
        return shapePath
    }
    private func drawShapeSquiggles(in rect: CGRect) -> UIBezierPath {
        let shapePath = UIBezierPath()
        let shapeOne5thWidth =  rect.width / 5
        let shapeOne5thHeight =  rect.height / 5
        let shapeOne10th =  rect.width / 10
        
        let scaleX = rect.width * SizeRatio.cellSpacing
        let scaleY = rect.height * SizeRatio.cellSpacing
        
        shapePath.move(to: CGPoint(x: rect.maxX - shapeOne10th - scaleX, y: rect.minY + scaleY))
        shapePath.addCurve(
            to: CGPoint(x: rect.maxX - shapeOne5thWidth - scaleX, y: rect.maxY - scaleY),
            controlPoint1: CGPoint(x: rect.maxX - scaleX, y: rect.minY + scaleY),
            controlPoint2: CGPoint(x: rect.maxX - scaleX, y: rect.maxY - scaleY))
        shapePath.addLine(to: CGPoint(x: rect.minX + shapeOne5thWidth + scaleX, y: rect.maxY - shapeOne5thHeight - scaleY))
        shapePath.addLine(to: CGPoint(x: rect.minX + shapeOne10th + scaleX, y: rect.maxY - scaleY))
        shapePath.addCurve(
            to: CGPoint(x: rect.minX + shapeOne5thWidth + scaleX, y: rect.minY + scaleY),
            controlPoint1: CGPoint(x: rect.minX + scaleX, y: rect.maxY - scaleY),
            controlPoint2: CGPoint(x: rect.minX + scaleX, y: rect.minY + scaleY))
        shapePath.addLine(to: CGPoint(x: rect.maxX - shapeOne5thWidth - scaleX, y: rect.minY + shapeOne5thHeight + scaleY))
        shapePath.close()
        
        return shapePath
    }
    
    private func drawStripedShading(in rect: CGRect, for shapePath: UIBezierPath) {
        let yPoint = rect.maxY
        let numberOfStripes = Int(rect.width / SizeRatio.stripesInterval)
        UIGraphicsGetCurrentContext()?.saveGState()
        shapePath.addClip()
        for xPoint in 0..<numberOfStripes {
            shapePath.move(to: CGPoint(x: CGFloat(xPoint) * SizeRatio.stripesInterval, y: 0))
            shapePath.addLine(to: CGPoint(x: CGFloat(xPoint) * SizeRatio.stripesInterval, y: yPoint))
        }
        shapePath.stroke()
        UIGraphicsGetCurrentContext()?.restoreGState()
    }
    
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        drawShapes();
    }

}

extension CardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cellSpacing: CGFloat = 0.2
        static let stripesInterval: CGFloat = 5
    }
    private var ShapeColor: UIColor {
        switch color {
        case .green:
            return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case .purple:
            return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case .red:
            return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
}
