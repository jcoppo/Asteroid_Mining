//
//  ShopButton.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/27/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import SpriteKit

class ShopButton: SKNode {
    
    var shape = SKShapeNode()
    var radius: CGFloat = 30
    
    let label = SKLabelNode(fontNamed: Font.font)
    
    var inShopMode = false
    
    override init() {
        super.init()
        
        name = "shop"

        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: -50, y: radius))
        path.addLine(to: CGPoint(x: 50, y: radius))
        path.addArc(center: CGPoint(x: 50, y: 0), radius: radius, startAngle: CGFloat.pi/2, endAngle: -CGFloat.pi/2, clockwise: true)
        path.addLine(to: CGPoint(x: -50, y: -radius))
        path.addArc(center: CGPoint(x: -50, y: 0), radius: radius, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: true)
        
        shape = SKShapeNode(path: path)
        shape.lineWidth = 5
        addChild(shape)
        
        label.fontSize = 40
        label.color = UIColor.white
        label.verticalAlignmentMode = .center
        addChild(label)
        
        shopMode()
    }
    
    func shopMode() {
        
        label.text = "Shop"

        shape.fillColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1.0)
        shape.strokeColor = UIColor.green

        
    }
    
    func playMode() {
        
        label.text = "Play"
        
        shape.fillColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1.0)
        shape.strokeColor = UIColor.blue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
