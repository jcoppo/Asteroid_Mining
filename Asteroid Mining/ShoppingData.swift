//
//  ShoppingData.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 7/3/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import Foundation
import SpriteKit

struct ShopItem {
    var name = String()
    var node = SKNode()
    var pic = UIImage()
    var costElements = [ElementCost]()
    init(name: String, node: SKNode, pic: UIImage, costElements: [ElementCost]) {
        self.name = name
        self.node = node
        self.pic = pic
        self.costElements = costElements
    }
}

struct ElementCost {
    var element = Element()
    var cost = Int()
    init(element: Element, cost: Int) {
        self.element = element
        self.cost = cost
    }
}

struct ShoppingList {
    
    var itemsArray = [ShopItem]()
    var elements = Elements()

    init() {
        
        let woodBlock = ShopItem(name: "Wood Block", node: SKNode(), pic: UIImage(), costElements: [
            ElementCost(element: elements.H, cost: 100),
            ElementCost(element: elements.C, cost: 100),
            ElementCost(element: elements.N, cost: 50),
            ElementCost(element: elements.O, cost: 50),
            ElementCost(element: elements.P, cost: 20),
            ElementCost(element: elements.S, cost: 20)])
        
        itemsArray.append(woodBlock)
        
        let steelBlock = ShopItem(name: "Steel Block", node: SKNode(), pic: UIImage(), costElements: [
            ElementCost(element: elements.Al, cost: 20),
            ElementCost(element: elements.Fe, cost: 50),
            ElementCost(element: elements.Ni, cost: 20)])
        
        itemsArray.append(steelBlock)
        
        let grassFloor = ShopItem(name: "Wood Block", node: SKNode(), pic: UIImage(), costElements: [
            ElementCost(element: elements.H, cost: 50),
            ElementCost(element: elements.C, cost: 50),
            ElementCost(element: elements.N, cost: 50),
            ElementCost(element: elements.O, cost: 50)])
        
        itemsArray.append(grassFloor)
        
//        var steelBlock = ShopItem(name: "Steel Block", node: SKNode(), pic: UIImage())
//        steelBlock.costElements.Al.amount = 20
//        steelBlock.costElements.Fe.amount = 50
//        steelBlock.costElements.Ni.amount = 20
//        itemsArray.append(steelBlock)
//        
//        var grassFloor = ShopItem(name: "Grass Floor", node: SKNode(), pic: UIImage())
//        grassFloor.costElements.H.amount = 50
//        grassFloor.costElements.C.amount = 50
//        grassFloor.costElements.N.amount = 50
//        grassFloor.costElements.O.amount = 50
//        itemsArray.append(grassFloor)
//        
        
    }
}
