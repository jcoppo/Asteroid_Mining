//
//  ExitButton.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/26/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import SpriteKit

class ExitButton: SKNode {
    
    var circle = SKShapeNode()
    let radius: CGFloat = 30
    
    override init() {
        super.init()
        
        circle = SKShapeNode(circleOfRadius: radius)
        circle.lineWidth = 4
        circle.strokeColor = UIColor(white: 0.9, alpha: 1.0)
        addChild(circle)
        
        let theArrow = SKShapeNode(path: makePath(bounds: circle.frame))
        theArrow.lineWidth = 4
        circle.addChild(theArrow)
        
        name = "exit"
        
    }
    
    func makePath(bounds: CGRect) -> CGMutablePath{
        
        let minX = CGFloat(bounds.minX+circle.lineWidth), minY = bounds.minY+circle.lineWidth, w = bounds.width-circle.lineWidth, h = bounds.height-circle.lineWidth;
        print(bounds)
        let pathPath = CGMutablePath()
        
        pathPath.move(to: CGPoint(x:-10, y: -10))
        pathPath.addLine(to: CGPoint(x:10, y: 0))
        pathPath.addLine(to: CGPoint(x:-10, y: 10))
        
        return pathPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
