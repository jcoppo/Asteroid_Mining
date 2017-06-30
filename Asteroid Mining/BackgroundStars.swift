//
//  BackgroundStars.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/22/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import SpriteKit

class BackgroundStars: SKNode {
    
    override init() {
        super.init()
        
        for _ in 0..<20 {
            let star = SKShapeNode(circleOfRadius: 1)
            star.fillColor = UIColor.white
            star.lineWidth = 0
            addChild(star)
            let x = random(-600, 600)
            let y = random(-600, 600)
            star.position = CGPoint(x: x, y: y)
        }

        zPosition = -100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
