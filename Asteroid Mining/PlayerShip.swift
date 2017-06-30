//
//  Player.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/21/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import SpriteKit

class PlayerShip: SKNode {
    
    var sprite = SKSpriteNode(imageNamed: "Spaceship")
    var world_x = 0
    var world_y = 0
    var hp = 1
    var isHittable = true
    var isAtHomeBase = true
    
    var elements = Elements()
    
    override init() {
        super.init()
        
        sprite.size = CGSize(width: 100, height: 100)
        addChild(sprite)
        
        physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Spaceship"), size: sprite.size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.linearDamping = 0.5
        physicsBody?.angularDamping = 4.0
        physicsBody?.restitution = 0.5
        physicsBody?.categoryBitMask = BitMask.Player
        physicsBody?.collisionBitMask = BitMask.Asteroid
        physicsBody?.contactTestBitMask = BitMask.Asteroid | BitMask.MotherShip
        physicsBody?.fieldBitMask = GravMask.None
            
    }
    
    func dieExplosion() {
        
        //particle explosion effect
        for _ in 0..<20 {
            let side = random(10, 30)
            let particle = SKShapeNode(rectOf: CGSize(width: side, height: side))
            particle.fillColor = randomColor()
            particle.lineWidth = 0
            particle.physicsBody = SKPhysicsBody()
            particle.physicsBody?.velocity = CGVector(dx: random(-200, 200), dy: random(-200, 200))
            particle.physicsBody?.fieldBitMask = GravMask.None
            addChild(particle)
            
            let duration = TimeInterval(random(1, 1.5))
            
            particle.run(SKAction.sequence([
                SKAction.wait(forDuration: duration),
                SKAction.removeFromParent()
                ]))
        }

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
