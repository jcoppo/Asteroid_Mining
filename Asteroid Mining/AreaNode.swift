//
//  AreaNode.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/22/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import SpriteKit

class AreaNode: SKNode {
    
    var area = AreaName.PlayRoom //default
    var circle = SKShapeNode()
    var radius: CGFloat = 40 
    var color = UIColor()
    var elements = [Element]()
    var isSelected = false

    override init() {
        super.init()
    }
    
     init(area: AreaName, color: UIColor, position: CGPoint, elements: [Element]) {
        super.init()
        
        self.area = area
        self.name = area.rawValue
        self.color = color
        self.position = position
        self.elements = elements
                
        circle = SKShapeNode(circleOfRadius: radius)
        circle.fillColor = color
        circle.lineWidth = 0
        addChild(circle)
        
        if area == .PlayRoom {
            circle.lineWidth = 4
            circle.strokeColor = UIColor.blue
            let blueHouse = SKSpriteNode(imageNamed: "house")
            blueHouse.size = CGSize(width: 1.2*radius, height: 1.2*radius)
            addChild(blueHouse)
        }
    }
    
    func expand() {
        run(SKAction.sequence([
            SKAction.scale(to: 2.7, duration: 0.2),
            SKAction.scale(to: 2.5, duration: 0.1),
            ]))
    }
    
    func shirnk() {
        run(SKAction.scale(to: 1.0, duration: 0.2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
