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
        
        //make average color out of element colors
        
        switch type {
        case .Mine:
            
            width = random(200, 300)
            let numPoints = 4 + Int(arc4random_uniform(3))
            
            let points = makePointsInCircle(centerPoint: CGPoint(x: 0, y: 0), radius: width/2, numberOfPoints: numPoints)
            
            let path = CGMutablePath()
            path.move(to: CGPoint(x: points[0].x, y: points[0].y))
            
            for i in 1..<points.count {
                
                path.addLine(to: CGPoint(x: points[i].x, y: points[i].y))
            }
            
            shape = SKShapeNode(path: path)
            shape.fillColor = UIColor.white
            shape.lineWidth = 0
            
            physicsBody = SKPhysicsBody(polygonFrom: path)
            
            var color1 = CIColor()
            var color2 = CIColor()
            
            if elements.count == 1 {
                
                color1 = CIColor(color: elements[0].color)
                color2 = CIColor.white()

            } else {
                
            
                color1 = CIColor(color: elements[0].color)
                color2 = CIColor(color: elements[1].color)
            }
            
            let gradTexture = gradientTexture(
                size: CGSize(width: width, height: width),
                color1: color1,
                color2: color2,
                direction: .Up)
            
            
            let pictureToMask = SKSpriteNode(texture: gradTexture, size: gradTexture.size())
            
            
            let cropNode = SKCropNode()
            cropNode.maskNode = shape
            cropNode.addChild(pictureToMask)
            //            cropNode.position = CGPoint(x: frame.midX, y: frame.midY)
            addChild(cropNode)
            
            physicsBody?.angularVelocity = random(-1, 1)
            
            
        case .Death:
            
            width = random(100, 600)
            let numPoints = 3 + Int(arc4random_uniform(4))

            let points = makePointsInCircle(centerPoint: CGPoint(x: 0, y: 0), radius: width/2, numberOfPoints: numPoints)

            let offsetRange: CGFloat = 50
            
            let path = CGMutablePath()
            path.move(to: CGPoint(x: points[0].x + random(-offsetRange, offsetRange), y: points[0].y + random(-offsetRange, offsetRange)))
            
            for i in 1..<points.count {
                
                 path.addLine(to: CGPoint(x: points[i].x + random(-offsetRange, offsetRange), y: points[i].y + random(-offsetRange, offsetRange)))
            }
            
            shape = SKShapeNode(path: path)
            shape.fillColor = UIColor(white: 0.4, alpha: 1.0)
            shape.strokeColor = UIColor(white: 0.2, alpha: 1.0)
            shape.lineWidth = 2

            physicsBody = SKPhysicsBody(polygonFrom: path)
            physicsBody?.angularVelocity = random(-1, 1)
            
            addChild(shape)

        }
        
        
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
        
        
        zRotation = random(0, 2*CGFloat.pi)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

