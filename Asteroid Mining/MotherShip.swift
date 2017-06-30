//
//  MotherShip.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/23/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import Foundation
import SpriteKit

class MotherShip: SKNode {
    
    var rectangle = SKShapeNode()
    
    override init() {
        super.init()
        
        rectangle = SKShapeNode(rectOf: CGSize(width: 200, height: 200))
        rectangle.lineWidth = 10
        rectangle.fillColor = UIColor(white: 0.7, alpha: 1.0)
        rectangle.strokeColor = UIColor(white: 0.2, alpha: 1.0)
        addChild(rectangle)
        
        physicsBody = SKPhysicsBody(rectangleOf: rectangle.frame.size)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = BitMask.MotherShip
        physicsBody?.collisionBitMask = BitMask.None
        physicsBody?.contactTestBitMask = BitMask.Player | BitMask.Asteroid
        physicsBody?.fieldBitMask = GravMask.None
        
        //
        let motherShipGravityNode = SKFieldNode.radialGravityField()
        motherShipGravityNode.strength = 5
        motherShipGravityNode.categoryBitMask = GravMask.Mother
        addChild(motherShipGravityNode)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
