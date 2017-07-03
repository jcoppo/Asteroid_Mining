//
//  Asteroid.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/21/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import SpriteKit

class Asteroid: SKNode {
    
    var shape = SKShapeNode()
    var radius = CGFloat()
    var width = CGFloat()
    var type = AsteroidType.Mine
    var area = String()
    var isHittable = true
    var hp = Int()
    var elements = [Element]()
    var areaElements = [Element]()
    var delegate: AsteroidDelegate?
    
    init(areaElements: [Element]) {
        super.init()
        
        self.areaElements = areaElements
        
        //determine which kind of asteroid it is. if .Mine, determine if it has 1,2,3,or4 elements. Choose which elements based on the area we're in.
        
        //determine type
        let n = random(0, 1)
        if n < 0.5 {
            type = AsteroidType.Mine
        }
        if n >= 0.5 {
            type = AsteroidType.Death
        }
        
        
        let numberOfElements = Int(random(1, 5))
        
        for _ in 0..<numberOfElements {
            let element = chooseElement()
            elements.append(element)
        }
        
        hp = numberOfElements
        
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
    
    func chooseElement() -> Element {
        
        var chosenElement = Element()
        var totalRarityNum: CGFloat = 0
        var elementsToChoose = [Element]()
        
        for var element in areaElements {
            element.minNum = totalRarityNum
            totalRarityNum += element.rarity
            element.maxNum = totalRarityNum
            elementsToChoose.append(element)
        }
        
        let choose = random(0, totalRarityNum)
        
        for element in elementsToChoose {
            if (element.minNum ... element.maxNum).contains(choose) {
                chosenElement = element
                chosenElement.amount = Int(random(1, 4))
            }
        }
        
        return chosenElement
    }

    
    func hit() {
        if isHittable {
            
            isHittable = false
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block:{_ in self.isHittable = true})
            
            hp -= 1
            if hp <= 0 {
//                destroyed()
                delegate?.asteroidMined(asteroid: self)
            }
            
            //add line crack
            
            let line = SKShapeNode(rectOf: CGSize(width: width*random(0.5, 0.9), height: 4))
            line.fillColor = UIColor(white: 0.3, alpha: 1.0)
            line.lineWidth = 0
            line.zRotation = random(0, CGFloat.pi*2)
            shape.addChild(line)
        }
    }
    
    func destroyed() {
                
        shape.isHidden = true
        
        for i in 0..<elements.count {
            let element = elements[i]
            let label = SKLabelNode(fontNamed: "Arial")
            label.position = CGPoint(x: 0, y: CGFloat(i)*50)
            label.text = "\(element.amount) \(element.name)"
            addChild(label)
        }
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 2.0),
            SKAction.removeFromParent()
            ]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




