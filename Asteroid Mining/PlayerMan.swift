//
//  PlayerMan.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/27/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import SpriteKit

class PlayerMan: SKNode {
    
    var sprite = SKSpriteNode(imageNamed: "penguin")
    
    override init() {
        super.init()
        
        sprite.size = CGSize(width: 80, height: 90)
        addChild(sprite)
        
        
        physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "penguin"), size: sprite.size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = true
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.friction = 0.2
        physicsBody?.restitution = 0.2
//        physicsBody?.categoryBitMask = UInt32()
//        physicsBody?.collisionBitMask = UInt32()
//        physicsBody?.contactTestBitMask = UInt32()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
