//
//  Global.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/22/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import CoreImage

struct Font {
    static let font = "Papyrus"
}

struct ViewControllers {
    static var gameVC = GameViewController()
}

struct CurrentArea {
    static var name = String()
}

enum GameMode {
    case InPlay
    case Dead
    case Shopping
}

enum AsteroidType {
    case Death
    case Mine
}

enum AreaName: String {
    case PlayRoom = "Play Room"
    case BirthingStar = "Birthing Star"
    case GiantsRings = "Giant's Rings"
    case ShatteredGlass = "Shattered Glass"
    case RockyRoad = "Rocky Road"
    case SparklingSector = "Sparkling Sector"
}

protocol AsteroidDelegate {
    func asteroidMined(asteroid: Asteroid)
}

//singleton is shared and mutated by all classes
class ElementsGained {
    static let data = ElementsGained()
    var elements = Elements()
}


//struct Area {
//    var name = String()
//    var color = UIColor()
//    var position = CGPoint()
//    var elements = [Element]()
//    init(name: String, color: UIColor, position: CGPoint, elements: [Element]) {
//        self.name = name
//        self.color = color
//        self.position = position
//        self.elements = elements
//    }
//    init() {}
//}

struct BitMask {
    static let Player: UInt32 = 0x1 << 0
    static let Asteroid: UInt32  = 0x1 << 1
    static let MotherShip: UInt32 = 0x1 << 2
    static let None: UInt32 = 0x1 << 3
}

struct GravMask {
    static let Mother: UInt32 = 0x1 << 4
    static let None: UInt32 = 0x1 << 5
    
}


////// ***** helpfull functions *** //////

func random(_ lowerLimit: CGFloat, _ upperLimit: CGFloat) -> CGFloat {
    return lowerLimit + CGFloat(arc4random()) / CGFloat(UInt32.max) * (upperLimit - lowerLimit)
}

func randomColor() -> UIColor {
    let r = random(0, 1)
    let g = random(0, 1)
    let b = random(0, 1)
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
}


func pointDistance(point1: CGPoint, point2: CGPoint) -> CGFloat {
    let dx = abs(point2.x - point1.x)
    let dy = abs(point2.y - point1.y)
    return sqrt(pow(dx, 2) + pow(dy, 2))
}


func pointDirection(point1: CGPoint, point2: CGPoint) -> CGFloat {
    let dx = point2.x - point1.x
    let dy = point2.y - point1.y
    return atan2(dy, dx)
}

func makePointsInCircle(centerPoint: CGPoint, radius: CGFloat, numberOfPoints: Int) -> [CGPoint] {
    var points = [CGPoint]()
    for i in 0..<numberOfPoints {
        let angle = 2*CGFloat.pi/CGFloat(numberOfPoints) * CGFloat(i)
        let pos_x = centerPoint.x + radius*cos(angle)
        let pos_y = centerPoint.y + radius*sin(angle)
        let point = CGPoint(x: pos_x, y: pos_y)
        points.append(point)
    }
    return points
}

public enum GradientDirection {
    case Up
    case Left
    case UpLeft
    case UpRight
}

func gradientTexture(size: CGSize, color1: CIColor, color2: CIColor, direction: GradientDirection) -> SKTexture {
    
    let context = CIContext(options: nil)
    let filter = CIFilter(name: "CILinearGradient")
    var startVector: CIVector
    var endVector: CIVector
    
    filter!.setDefaults()
    
    switch direction {
    case .Up:
        startVector = CIVector(x: size.width * 0.5, y: 0)
        endVector = CIVector(x: size.width * 0.5, y: size.height)
    case .Left:
        startVector = CIVector(x: size.width, y: size.height * 0.5)
        endVector = CIVector(x: 0, y: size.height * 0.5)
    case .UpLeft:
        startVector = CIVector(x: size.width, y: 0)
        endVector = CIVector(x: 0, y: size.height)
    case .UpRight:
        startVector = CIVector(x: 0, y: 0)
        endVector = CIVector(x: size.width, y: size.height)
    }
    
    filter!.setValue(startVector, forKey: "inputPoint0")
    filter!.setValue(endVector, forKey: "inputPoint1")
    filter!.setValue(color1, forKey: "inputColor0")
    filter!.setValue(color2, forKey: "inputColor1")
    
    let image = context.createCGImage(filter!.outputImage!, from: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    
    let texture = SKTexture(cgImage: image!)
    return texture
}

