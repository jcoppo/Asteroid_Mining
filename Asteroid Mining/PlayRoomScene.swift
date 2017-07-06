//
//  GameScene.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/21/17.
//  Copyright © 2017 Jayson Coppo. All rights reserve

import SpriteKit
import GameplayKit


class PlayRoomScene: SKScene, SKPhysicsContactDelegate {
    
    var gameMode = GameMode.InPlay
    var gameVC: GameViewController?
    
    let cameraNode = SKCameraNode()
    let player = PlayerMan()
    let exitButton = ExitButton()
//    let shopButton = ShopButton()
    let labelParentNode = SKNode()
    
    let roomWidth: CGFloat = 2000
    let roomHeight: CGFloat = 2000
    let flickSpeed: CGFloat = 20
    let speedLimit: CGFloat = 800
    
    let elementsGained = ElementsGained.data
    
//    var vcDelegate: SceneToViewControllerDelegate?
    
    
    override func didMove(to view: SKView) {
        
//        backgroundColor = UIColor.cyan
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -8)
        
        tileBackground()
        
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.zPosition = 10
        cameraNode.position = CGPoint(x: -roomWidth/2+250, y: -roomHeight/2+550)
            
        let floorWall = Wall(size: CGSize(width: roomWidth, height: 300))
        floorWall.position = CGPoint(x: 0, y: -roomHeight/2)
        addChild(floorWall)
        
        let topWall = Wall(size: CGSize(width: roomWidth, height: 300))
        topWall.position = CGPoint(x: 0, y: roomHeight/2)
        addChild(topWall)
        
        let rightWall = Wall(size: CGSize(width: 600, height: roomHeight+300))
        rightWall.position = CGPoint(x: -roomWidth/2-300, y: 0)
        addChild(rightWall)
            
        let leftWall = Wall(size: CGSize(width: 600, height: roomHeight+300))
        leftWall.position = CGPoint(x: roomWidth/2+300, y: 0)
        addChild(leftWall)
    
            
        player.position = CGPoint(x: -roomWidth/2+200, y: -roomHeight/2+100)
        addChild(player)
        
        exitButton.position = CGPoint(x: size.width/2-50, y: size.height/2-50)
//        exitButton.zPosition = 10
        cameraNode.addChild(exitButton)

//        shopButton.position = CGPoint(x: size.width/2-200, y: size.height/2-50)
//        exitButton.zPosition = 10
//        cameraNode.addChild(shopButton)
        
        cameraNode.addChild(labelParentNode)
        
        ViewControllers.gameVC.addPlayroomButtons()
        
    }
    
    func tileBackground() {
        
        for row in 0..<3 {
            for column in 0..<2 {
                
                let backgroundPic = SKSpriteNode(imageNamed: "stars")
                backgroundPic.anchorPoint = CGPoint(x: 0, y: 0)
                backgroundPic.size = CGSize(width: 1270, height: 710)
                backgroundPic.position = CGPoint(x: -roomWidth/2 + CGFloat(column)*1280, y: -roomHeight/2 + CGFloat(row)*720)
                backgroundPic.zPosition = -100
                addChild(backgroundPic)
            }
        }
    }
    
    func exitToOverworld() {
        
        ViewControllers.gameVC.removePlayroomButtons()
        
        let newScene = OverWorldScene()
        newScene.size = size
        newScene.scaleMode = SKSceneScaleMode.aspectFill
        view?.presentScene(newScene)
    }
    
    func shopButtonPressed() {
        
        if gameMode == .InPlay {
            
            gameMode = .Shopping
            ViewControllers.gameVC.showTable()
//            shopButton.playMode()
            
            
            //show gained element list
            labelParentNode.removeAllChildren()
        
            var numberOfLabels = 0
            
            //title label
            let titleLabel = SKLabelNode(fontNamed: Font.font)
            titleLabel.position = CGPoint(x: -size.width/2, y: size.height/2)
            titleLabel.horizontalAlignmentMode = .left
            titleLabel.fontSize = 40
            titleLabel.text = "My Resources"
            labelParentNode.addChild(titleLabel)
            numberOfLabels += 1
            
            for i in 0..<elementsGained.elements.elementArray.count {
                    
                if elementsGained.elements.elementArray[i].amount > 0 {
                    
                    //show labels
                    numberOfLabels += 1
                    let label = SKLabelNode(fontNamed: Font.font)
                    label.position = CGPoint(x: -size.width/2, y: size.height/2 - CGFloat(numberOfLabels)*40)
                    label.horizontalAlignmentMode = .left
                    label.text = "\(elementsGained.elements.elementArray[i].amount) \(elementsGained.elements.elementArray[i].name)"
                    labelParentNode.addChild(label)
                    
                }
            }
            
            labelParentNode.isHidden = false
        
        } else {

            gameMode = .InPlay
            ViewControllers.gameVC.removeTable()
//            shopButton.shopMode()
            
            labelParentNode.isHidden = true

        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            
            for node in nodes(at: location) {
                if node.name == "exit" {
                    exitToOverworld()
                    if gameMode == .Shopping {
                        ViewControllers.gameVC.removeTable()
                    }
                }
                
//                if node.name == "shop" {
//                    shopButtonPressed()
//                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            let previous = t.previousLocation(in: self)
            
            //flick player around with a speed limit
            
            if gameMode == .InPlay {
                
                let dx = location.x - previous.x
                let dy = location.y - previous.y
                
                var xSpeed = flickSpeed*dx
                var ySpeed = flickSpeed*dy
                
                if xSpeed > speedLimit {
                    xSpeed = speedLimit
                }
                if xSpeed < -speedLimit {
                    xSpeed = -speedLimit
                }
                if ySpeed > speedLimit {
                    ySpeed = speedLimit
                }
                if ySpeed < -speedLimit {
                    ySpeed = -speedLimit
                }
                
                player.physicsBody?.velocity = CGVector(dx: xSpeed, dy: ySpeed)
                
                let direction = pointDirection(point1: previous, point2: location)
                player.zRotation = direction - CGFloat.pi/2
                player.physicsBody?.angularVelocity = 0
            }
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
//        let maskA = contact.bodyA.categoryBitMask
//        let maskB = contact.bodyB.categoryBitMask
//        var bodyA = SKPhysicsBody()
//        var bodyB = SKPhysicsBody()
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
//        let maskA = contact.bodyA.categoryBitMask
//        let maskB = contact.bodyB.categoryBitMask
//        var bodyA = SKPhysicsBody()
//        var bodyB = SKPhysicsBody()
        
    }
    
    override func didSimulatePhysics() {
        
        
        //camera follows player, except outsise of these x/y ranges
        if (-roomWidth/2+250...roomWidth/2-250).contains(player.position.x) {
            cameraNode.position.x = player.position.x
        }
        
        if (-roomHeight/2+550...roomHeight/2-750).contains(player.position.y) {
            cameraNode.position.y = player.position.y
        }
        
        //background paralax
//        backgroundPic.position.x = cameraNode.position.x*0.9

        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}

