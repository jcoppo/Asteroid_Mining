//
//  AsteroidBirthingStar.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/29/17s
//  Copyright © 2017 Jayson Coppo. All rights reserveds


import SpriteKit

class AsteroidBirthingStar: Asteroid {
    
    override init(areaElements: [Element]) {
        super.init(areaElements: areaElements)
        
        switch type {
        case .Mine:
            shape = SKShapeNode(circleOfRadius: radius)
            physicsBody = SKPhysicsBody(circleOfRadius: radius)
            shape.fillColor = randomColor()
            shape.lineWidth = 0
            
        case .Death:
            let w = random(100, 600)
            let h = random(100, 600)
            shape = SKShapeNode(rectOf: CGSize(width: w, height: h))
            shape.fillColor = UIColor(white: 0.4, alpha: 1.0)
            shape.lineWidth = 2
            shape.strokeColor = UIColor(white: 0.2, alpha: 1.0)
            physicsBody = SKPhysicsBody(rectangleOf: shape.frame.size)
            physicsBody?.angularVelocity = random(-1, 1)
        }
        
        addChild(shape)
        
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = true
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.friction = 0.5
        physicsBody?.restitution = 0.5
        physicsBody?.mass = 100
        physicsBody?.categoryBitMask = BitMask.Asteroid
        physicsBody?.collisionBitMask = BitMask.Player
        physicsBody?.contactTestBitMask = BitMask.Player | BitMask.MotherShip
        physicsBody?.fieldBitMask = GravMask.None

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
