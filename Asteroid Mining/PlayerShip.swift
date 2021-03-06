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
    
    var cueLine = SKShapeNode()
    var thruster = SKEmitterNode()
    var timeOfBoost = CGFloat()
    var lengthOfBoost = CGFloat()
    
    override init() {
        super.init()
        
        sprite.size = CGSize(width: 100, height: 100)
        sprite.zPosition = 100
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
        
        addThrusterParticle()
        
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
    
    func addCueLine(){
        cueLine = SKShapeNode()
        cueLine.fillColor = UIColor(colorLiteralRed: 1.0, green: 0.9, blue: 0.9, alpha: 1)
        cueLine.zPosition = -100
        addChild(cueLine)
    }
    
    func changeSizeOfCueLine(height: CGFloat){
        
        if height > 2{
            cueLine.removeFromParent()
            cueLine = SKShapeNode(rect: CGRect(x: 0, y: -height-sprite.size.height/2, width: 4, height: height), cornerRadius: 1)
            cueLine.fillColor = UIColor(colorLiteralRed: 1.0, green: 0.9, blue: 0.9, alpha: 0.3)
            cueLine.lineWidth = 0
            addChild(cueLine)
            timeOfBoost = height/1000
            lengthOfBoost = height/1000
            
        }
        
        
    }
    
    func removeCueLine(){
        cueLine.removeFromParent()
    }
    
    func addThrusterParticle(){
        
        let path = Bundle.main.path(forResource: "flame", ofType: "sks")
        thruster = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        thruster.name = "flame"
        thruster.targetNode = self.scene
        thruster.particleBirthRate = 0
        self.addChild(thruster)
        
        
    }
    
    func boost(){
        thruster.particleBirthRate = 1000
        thruster.particleLifetime = lengthOfBoost
        Timer.scheduledTimer(withTimeInterval: TimeInterval(timeOfBoost), repeats: false, block: {_ in self.thrusterOff()})
    }
    
    func thrusterOff(){
        thruster.particleBirthRate = 0
        lengthOfBoost = 0
    }
    
    
    func addLine(){
        let line = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 1, height: 100))
        line.fillColor = UIColor(colorLiteralRed: 1.0, green: 0, blue: 0, alpha: 1)
        self.addChild(line)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
