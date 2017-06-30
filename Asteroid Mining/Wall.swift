//
//  Floor.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/27/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import SpriteKit

class Wall: SKNode {
    
    var rectangle = SKShapeNode()
    
    init(size: CGSize) {
        super.init()
        
        rectangle = SKShapeNode(rectOf: size)
        rectangle.fillColor = UIColor(red: 200/255, green: 140/255, blue: 60/255, alpha: 1)
        rectangle.lineWidth = 0
        addChild(rectangle)
        
        physicsBody = SKPhysicsBody(rectangleOf: rectangle.frame.size)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false 
        physicsBody?.friction = 0.3
        physicsBody?.restitution = 0.5
//        physicsBody?.categoryBitMask = UInt32()
//        physicsBody?.collisionBitMask = UInt32()
//        physicsBody?.contactTestBitMask = UInt32()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
