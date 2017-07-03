//
//  GameScene.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/21/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate, AsteroidDelegate {
    
    var gameMode = GameMode.InPlay
    
    let cameraNode = SKCameraNode()
    let playerShip = PlayerShip()
    let motherShip = MotherShip()
    let backgroundStars = BackgroundStars()
    let exitButton = ExitButton()
    let labelParentNode = SKNode()
    var minedParticles = [SKNode]()
    var dropOffParticles = [SKNode]()
    var currentArea = AreaNode()

    var asteroidTimer = Timer()
    
    var playerIsTouchingMother = false
    
    let elementsGained = ElementsGained.data
    
    //movement variables
    let flickSpeed: CGFloat = 1
    let speedLimit: CGFloat = 400
    var xSpeed = CGFloat()
    var ySpeed = CGFloat()
    var touchStart = CGPoint()
    var touchEnd = CGPoint()
    
    init(size: CGSize, areaNode: AreaNode) {
        super.init(size: size)
        currentArea = areaNode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        addChild(cameraNode)
        camera = cameraNode
        
        addChild(backgroundStars)
        
        playerShip.position = CGPoint(x: 0, y: 0)
        playerShip.zPosition = 0
        addChild(playerShip)
        
        motherShip.position = playerShip.position
        motherShip.zPosition = -10
        addChild(motherShip)
        
        exitButton.position = CGPoint(x: size.width/2-50, y: size.height/2-50)
        cameraNode.addChild(exitButton)
        
        cameraNode.addChild(labelParentNode)
        
        asteroidTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block:{_ in self.makeAsteroid()})

    }
      
    
    func makeAsteroid() {
        
        //create asteroid
        
        var asteroid: Asteroid?
        
        switch currentArea.area {
        case .BirthingStar:
            asteroid = AsteroidBirthingStar(areaElements: currentArea.elements)
            
        default:
            break
        }
        
//        let asteroid = Asteroid(areaElements: currentArea.elements)
        asteroid!.delegate = self
        asteroid!.zPosition = -20
        asteroid!.name = "asteroid"
        
        //create asteroid 1000px away from player in any direction, then send it moving in the direction of player. 
        
        let angle = random(0, 2*CGFloat.pi)
        let viewRadius: CGFloat = 1000
        
        let x = playerShip.position.x+viewRadius*cos(angle)
        let y = playerShip.position.y+viewRadius*sin(angle)
        asteroid!.position = CGPoint(x: x, y: y)
        
        let travelAngle = angle + CGFloat.pi + random(-CGFloat.pi/4, CGFloat.pi/4)
        let velocity = random(20, 200)
        asteroid!.physicsBody?.velocity = CGVector(dx: velocity*cos(travelAngle), dy: velocity*sin(travelAngle))
        
        addChild(asteroid!)
        
    }
    
    func playerIsHit() {
        
        if playerShip.isHittable {
            playerShip.isHittable = false
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block:{_ in self.playerShip.isHittable = true})
            
            playerShip.hp -= 1
            if playerShip.hp <= 0 {
                playerDies()
            }
        }
    }
    
    func asteroidMined(asteroid: Asteroid) {
        
        //add the asteroid's elements to the ship's
        
        for element in asteroid.elements {
            for i in 0..<playerShip.elements.elementArray.count {
                if element.name == playerShip.elements.elementArray[i].name {
                    playerShip.elements.elementArray[i].amount += element.amount
                }
            }
        }
        
        asteroid.removeFromParent()
        
        //make element labels
        let labelParentNode = SKNode()
        labelParentNode.position = asteroid.position
        addChild(labelParentNode)
        
        for i in 0..<asteroid.elements.count {
            let element = asteroid.elements[i]
            let label = SKLabelNode(fontNamed: "Arial")
            label.position = CGPoint(x: 0, y: CGFloat(i)*40)
            label.text = "\(element.amount) \(element.name)"
            labelParentNode.addChild(label)
        }
        
        labelParentNode.run(SKAction.sequence([
            SKAction.wait(forDuration: 2.0),
            SKAction.fadeOut(withDuration: 0.2),
            SKAction.removeFromParent()
            ]))
        
        //particle effect
        minedParticles = [SKNode]()
        for _ in 0..<20 {
            let side = random(10, 30)
            let particle = SKShapeNode(rectOf: CGSize(width: side, height: side))
            let x = asteroid.position.x + random(-asteroid.radius, asteroid.radius)
            let y = asteroid.position.y + random(-asteroid.radius, asteroid.radius)
            particle.position = CGPoint(x: x, y: y)
            particle.fillColor = asteroid.shape.fillColor
            particle.lineWidth = 0
            addChild(particle)
            minedParticles.append(particle)
            
            particle.zPosition = -2
            
            let duration = TimeInterval(random(0.5, 0.8))
            
            particle.run(SKAction.sequence([
                SKAction.wait(forDuration: duration),
                SKAction.removeFromParent()
                ]))
        }
    }
    
    func asteroidHitsMother(asteroid: Asteroid) {
        
        asteroid.removeFromParent()
        
        //particle effect
        for _ in 0..<20 {
            let side = random(10, 30)
            let particle = SKShapeNode(rectOf: CGSize(width: side, height: side))
            let x = asteroid.position.x + random(-20, 20)
            let y = asteroid.position.y + random(-20, 20)
            particle.position = CGPoint(x: x, y: y)
            particle.fillColor = UIColor.gray
            particle.lineWidth = 0
            addChild(particle)
            
            particle.physicsBody = SKPhysicsBody()
            particle.physicsBody?.velocity = CGVector(dx: random(-500, 500), dy: random(-500, 500))
            
            particle.zPosition = -2
            
            let duration = TimeInterval(random(0.2, 0.5))
            
            particle.run(SKAction.sequence([
                SKAction.wait(forDuration: duration),
                SKAction.fadeOut(withDuration: 0.2),
                SKAction.removeFromParent()
                ]))
        }
    }
    
    func dropOffYourStuff() {
        print("drop off")
        //transfer ship's element amounts to mothership's, show labels of total gains, then empty the ship's
        
        labelParentNode.removeAllChildren()
        
        var numberOfLabels = 0
        let labels_yDown: CGFloat = 80
        dropOffParticles = [SKNode]()
        
        //title label
        let titleLabel = SKLabelNode(fontNamed: "Arial")
        titleLabel.position = CGPoint(x: -size.width/2, y: size.height/2-labels_yDown)
        titleLabel.horizontalAlignmentMode = .left
        titleLabel.fontSize = 40
        titleLabel.text = "My Resources" 
        labelParentNode.addChild(titleLabel)
        numberOfLabels += 1
        
        for element in playerShip.elements.elementArray {
            
                for i in 0..<elementsGained.elements.elementArray.count {
                    
                    if element.name == elementsGained.elements.elementArray[i].name {
                        
                        //transfer element data
                        elementsGained.elements.elementArray[i].amount += element.amount
                        
                        //particle effect
                        if element.amount > 0 {
                            
                            let side = random(10, 30)
                            let particle = SKShapeNode(rectOf: CGSize(width: side, height: side))
                            particle.position = playerShip.position
                            particle.fillColor = randomColor()
                            particle.lineWidth = 0
                            
                            addChild(particle)
                            dropOffParticles.append(particle)
                            
                            particle.physicsBody = SKPhysicsBody()
                            particle.physicsBody?.velocity = CGVector(dx: random(-200, 200), dy: random(-200, 200))
                            particle.physicsBody?.fieldBitMask = GravMask.Mother
                            
                            particle.zPosition = 2
                            
                            let duration = TimeInterval(random(0.5, 1.0))
                            
                            particle.run(SKAction.sequence([
                                SKAction.wait(forDuration: duration),
                                SKAction.removeFromParent()
                                ]))

                        }
                        
                        if elementsGained.elements.elementArray[i].amount > 0 {
                            
                            //show labels
                            let label = SKLabelNode(fontNamed: "Arial")
                            let x = -size.width/2
                            let y = size.height/2 - labels_yDown - CGFloat(numberOfLabels)*40
                            label.position = CGPoint(x: x, y: y)
                            label.horizontalAlignmentMode = .left
                            label.text = "\(elementsGained.elements.elementArray[i].amount) \(elementsGained.elements.elementArray[i].name)"
                            labelParentNode.addChild(label)
                            numberOfLabels += 1

                        }
                        
                    }
                }
        }
        
        labelParentNode.alpha = 1.0
        
        //empty the ship
        for i in 0..<playerShip.elements.elementArray.count {
            playerShip.elements.elementArray[i].amount = 0
        }
        
    }
    
    func playerDies() {
        
        gameMode = GameMode.Dead
        playerShip.physicsBody?.isDynamic = false
        playerShip.sprite.isHidden = true
        playerShip.dieExplosion()
        
        let cameraMove = SKAction.move(to: motherShip.position, duration: 1.0)
        cameraMove.timingMode = .easeInEaseOut
        
        cameraNode.run(SKAction.sequence([
            SKAction.wait(forDuration: 1.5),
            cameraMove,
            SKAction.run({self.resetGame()})
            ]))
        
        //empty the ship
        for i in 0..<playerShip.elements.elementArray.count {
            playerShip.elements.elementArray[i].amount = 0
        }
    }
    
    func resetGame() {
        gameMode = GameMode.InPlay
        playerShip.physicsBody?.isDynamic = true
        playerShip.sprite.isHidden = false
        playerShip.position = motherShip.position
    }
    
    func exitToOverworld() {
        
        let newScene = OverWorldScene()
        newScene.size = size
        newScene.scaleMode = SKSceneScaleMode.aspectFill
        view?.presentScene(newScene)
        
        newScene.selectedNode.expand()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            
            for node in nodes(at: location) {
                if node.name == "exit" {
                    exitToOverworld()
                }
            }
            
//            touchStart = location
//            touchStart.x = location.x - playerShip.position.x
//            touchStart.y = location.y - playerShip.position.y
            touchStart = t.location(in: cameraNode)
            
            playerShip.addCueLine()
            
//            //send player in direction of touchPoint
//            let direction = pointDirection(point1: playerShip.position, point2: location)
//            
//            let speed: CGFloat = 400
//            playerShip.physicsBody?.velocity = CGVector(dx: speed*cos(direction), dy: speed*sin(direction))
//            playerShip.zRotation = direction - CGFloat.pi/2
//            playerShip.physicsBody?.angularVelocity = 0
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            
            let location = t.location(in: self)
            print(location)
            let previous = t.previousLocation(in: self)
            
            //flick player around with a speed limit
            
            if gameMode == .InPlay {
                
//                touchEnd = location
//                touchEnd.x = location.x - playerShip.position.x
//                touchEnd.y = location.y - playerShip.position.y
                touchEnd = t.location(in: cameraNode)
                
                let length = pointDistance(point1: touchEnd, point2: touchStart)
                playerShip.changeSizeOfCueLine(height: length/2)
                
                let direction = pointDirection(point1: touchEnd, point2: touchStart)
                if length > 10{
                playerShip.zRotation = direction - CGFloat.pi/2
                playerShip.physicsBody?.angularVelocity = 0
            }
            }

        }
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        playerShip.removeCueLine()
        
        if gameMode == .InPlay{
            playerShip.boost()
        }
        
        for t in touches {
            let location = t.location(in: self)
            
//            touchEnd = location
            
            let dx = touchEnd.x - touchStart.x
            let dy = touchEnd.y - touchStart.y
            
            var xSpeed = dx
            var ySpeed = dy
            
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

            playerShip.physicsBody?.velocity.dx += -xSpeed
            playerShip.physicsBody?.velocity.dy += -ySpeed
            
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let maskA = contact.bodyA.categoryBitMask
        let maskB = contact.bodyB.categoryBitMask
        var bodyA = SKPhysicsBody()
        var bodyB = SKPhysicsBody()
        
        //between Player and Asteroid
        if (maskA == BitMask.Player && maskB == BitMask.Asteroid) ||
            (maskA == BitMask.Asteroid && maskB == BitMask.Player) {
            
            if maskA == BitMask.Player {
                bodyA = contact.bodyA
                bodyB = contact.bodyB
            }
            if maskA == BitMask.Asteroid {
                bodyA = contact.bodyB
                bodyB = contact.bodyA
            }
            
            if let asteroid = bodyB.node as? Asteroid {
                if asteroid.type == AsteroidType.Mine {
                    asteroid.hit()
                }
                if asteroid.type == AsteroidType.Death {
                    if playerShip.isAtHomeBase == false {
                        playerIsHit()
                    }
                }
                
            }
        }
        
        //between asteroid and mothership
        if (maskA == BitMask.Asteroid && maskB == BitMask.MotherShip) ||
            (maskA == BitMask.MotherShip && maskB == BitMask.Asteroid) {
            
            if maskA == BitMask.Asteroid {
                bodyA = contact.bodyA
                bodyB = contact.bodyB
            }
            if maskA == BitMask.MotherShip {
                bodyA = contact.bodyB
                bodyB = contact.bodyA
            }
            
            if let asteroid = bodyA.node as? Asteroid {
                asteroidHitsMother(asteroid: asteroid)
            }
        }
        
        //between player and mothership
        if (maskA == BitMask.Player && maskB == BitMask.MotherShip) ||
            (maskA == BitMask.MotherShip && maskB == BitMask.Player) {
            
            playerShip.isAtHomeBase = true
            
            if playerIsTouchingMother == false {
                dropOffYourStuff()
            }
            playerIsTouchingMother = true
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
        let maskA = contact.bodyA.categoryBitMask
        let maskB = contact.bodyB.categoryBitMask
//        var bodyA = SKPhysicsBody()
//        var bodyB = SKPhysicsBody()
        
        if (maskA == BitMask.Player && maskB == BitMask.MotherShip) ||
            (maskA == BitMask.MotherShip && maskB == BitMask.Player) {
            
            labelParentNode.run(SKAction.sequence([
                SKAction.wait(forDuration: 0.4),
                SKAction.fadeOut(withDuration: 0.2),
            ]))

            
            playerShip.isAtHomeBase = false
            playerIsTouchingMother = false
        }
    }
    
    override func didSimulatePhysics() {
        
        if gameMode == .InPlay {
            cameraNode.position = playerShip.position
        }
        
        //paralax
        backgroundStars.position.x = cameraNode.position.x*0.9
        backgroundStars.position.y = cameraNode.position.y*0.9
        
        //remove an asteroid if it's 1500px away from player
        
        self.enumerateChildNodes(withName: "asteroid") {
            asteroid, stop in
            if pointDistance(point1: self.playerShip.position, point2: asteroid.position) >= 1500 {
                asteroid.removeFromParent()
            }
        }
        
        //mined particles to follow ship
        for particle in minedParticles {
            let direction = pointDirection(point1: particle.position, point2: playerShip.position)
            particle.position.x += 6*cos(direction)
            particle.position.y += 6*sin(direction)
        }
//        
        for particle in dropOffParticles {
            if pointDistance(point1: particle.position, point2: motherShip.position) < 20 {
                particle.removeFromParent()
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
    }
}

