//
//  OverWorldScene.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/22/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//


import SpriteKit

class OverWorldScene: SKScene {
    
    let cameraNode = SKCameraNode()
    let playerIcon = SKSpriteNode(imageNamed: "Spaceship")
    var areaLabel = SKLabelNode(fontNamed: "Arial")
    let backgroundStars = BackgroundStars()
    let elements = Elements()
    var areaNodes = [AreaNode]()
    var selectedNode = AreaNode()

    var playRoom = AreaNode()
    var birthingStar = AreaNode()
    var giantsRings = AreaNode()
    var shatteredGlass = AreaNode()
    var rockyRoad = AreaNode()
    var sparklingSector = AreaNode()
    
    var gameVC = GameViewController()
    
    
    override func didMove(to view: SKView) {
        
        print("is there a conflict? No?")
        
        backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        
        makeAreaNodesAndLines()
        
        playerIcon.size = CGSize(width: 100, height: 100)
//        playerIcon.alpha = 0.6
        addChild(playerIcon)
        
        //get the last current node saved in CurrentArea.name
        for areaNode in areaNodes {
            if areaNode.name == CurrentArea.name {
                selectedNode = areaNode
                areaNode.expand()
                playerIcon.position = selectedNode.position
            }
        }
        
        //camera
        camera = cameraNode
        cameraNode.position = birthingStar.position
        addChild(cameraNode)
        
        areaLabel.position = CGPoint(x: -size.width/2+20, y: size.height/2-80)
        areaLabel.horizontalAlignmentMode = .left
        areaLabel.fontSize = 60
        areaLabel.text = "\(selectedNode.name ?? "nawr")"
        cameraNode.addChild(areaLabel)
        
        backgroundStars.zPosition = -100
        cameraNode.addChild(backgroundStars)
        
    }
    
    func makeAreaNodesAndLines() {
        
        
        playRoom = AreaNode(area: .PlayRoom,
                            color: UIColor.white,
                            position: CGPoint(x: -150, y: -400),
                            elements: [Element]()
        )
        addChild(playRoom)
        
        birthingStar = AreaNode(
            area: .BirthingStar,
            color: UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 1.0),
            position: CGPoint(x: 0, y: 0),
            elements: [elements.H,
                       elements.He,
                       elements.Li,
                       elements.C,
                       elements.N,
                       elements.O,
                       elements.Na,
                       elements.Al,
                       elements.P,
                       elements.S,
                       elements.Cl,
                       elements.Ca,
                       elements.Fe,
                       elements.Ni
            ]
        )
        addChild(birthingStar)
        
        giantsRings = AreaNode(
            area: .GiantsRings,
            color: UIColor(red: 255/255, green: 152/255, blue: 255/255, alpha: 1.0),
            position: CGPoint(x: 200, y: 200),
            elements: [elements.H,
                       elements.Li,
                       elements.Be,
                       elements.B,
                       elements.C,
                       elements.N,
                       elements.O,
                       elements.F,
                       elements.Mg,
                       elements.Al,
                       elements.S,
                       elements.Ca,
                       elements.Fe,
                       elements.Ni,
                       elements.Zn,
                       elements.As,
                       elements.Kr,
                       elements.Ag,
                       elements.Au,
                       elements.U
            ]
        )
        addChild(giantsRings)
        
        shatteredGlass = AreaNode(
            area: .ShatteredGlass,
            color: UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1.0),
            position: CGPoint(x: 200, y: -200),
            elements: [elements.H,
                       elements.Li,
                       elements.Be,
                       ]
        )
        addChild(shatteredGlass)
        
        rockyRoad = AreaNode(
            area: .RockyRoad,
            color: UIColor(red: 128/255, green: 0/255, blue: 0/255, alpha: 1.0),
            position: CGPoint(x: -300, y: 0),
            elements: [elements.H,
                       elements.Li,
                       elements.Be,
                       ]
        )
        addChild(rockyRoad)
        
        sparklingSector = AreaNode(
            area: .SparklingSector,
            color: UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0),
            position: CGPoint(x: -500, y: 200),
            elements: [elements.H,
                       elements.Li,
                       elements.Be,
                       ]
        )
        addChild(sparklingSector)
        
        areaNodes = [playRoom, birthingStar, giantsRings, shatteredGlass, rockyRoad, sparklingSector]
        
        
        //make lines between Nodes
        makeLineBetween(playRoom, birthingStar)
        makeLineBetween(birthingStar, giantsRings)
        makeLineBetween(birthingStar, shatteredGlass)
        makeLineBetween(birthingStar, rockyRoad)
        makeLineBetween(rockyRoad, sparklingSector)

        
    }
    
    func makeLineBetween(_ area1: AreaNode, _ area2: AreaNode) {
        
        let point1 = area1.position
        let point2 = area2.position
        
        let path = CGMutablePath()
        path.move(to: point1)
        path.addLine(to: point2)
        
        let line = SKShapeNode(path: path)
        line.strokeColor = UIColor(white: 0.95, alpha: 0.7)
        line.lineWidth = 10
        addChild(line)
        
        line.zPosition = -50
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            
            for areaNode in areaNodes {
                if pointDistance(point1: areaNode.position, point2: location) < 100 {
                    
                    //if node is tapped and is not selected, select it. If it's already selected, go to gamescene with that area 
                    
                    if areaNode == selectedNode {
                        areaNode.expand()
                        
                        if areaNode.area == .PlayRoom {
                            
                            //go to play room
                            let newScene = PlayRoomScene()
                            newScene.size = size
                            newScene.scaleMode = SKSceneScaleMode.aspectFill
                            view?.presentScene(newScene)
                            
                        } else {
                            
                            //go to gamescene
                            let newScene = GameScene(size: size, areaNode: selectedNode)
                            newScene.size = size
                            newScene.scaleMode = SKSceneScaleMode.aspectFill
                            view?.presentScene(newScene)
                        }
                    } else {
                        //update area label
                        selectedNode.shirnk()
                        areaNode.expand()
                        selectedNode = areaNode
                        areaLabel.text = "\(selectedNode.name ?? "whatevs?")"
                        
                        CurrentArea.name = areaNode.name!
                        
                        playerIcon.position = selectedNode.position
                        
                        //center camera on these if selected
                        if selectedNode.name == "Birthing Star" || selectedNode.name == "Rocky Road" {
                            let moveAction = SKAction.move(to: selectedNode.position, duration: 0.8)
                            moveAction.timingMode = .easeInEaseOut
                            cameraNode.run(moveAction)
                        }
                    }
                }
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}






