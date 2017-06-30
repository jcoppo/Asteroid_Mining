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
        circle.lineWidth = 5
        circle.strokeColor = UIColor(white: 0.9, alpha: 1.0)
//        circle.fillColor = UIColor.gray
        addChild(circle)
        
        name = "exit"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
