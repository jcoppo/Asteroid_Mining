//
//  ElementData.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/28/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import Foundation
import UIKit

struct Element {
    var name = String()
    var symbol = String()
    //the rarity number is used to determine how often it appears in asteroids 
    var rarity = CGFloat()
    var color = UIColor()
    //for determining if used
    var minNum = CGFloat()
    var maxNum = CGFloat()
    // this is the quantity of the element, in an arbitrary "unit"
    var amount = 0
    //
    init(name: String, symbol: String, rarity: CGFloat, color: UIColor) {
        self.name = name
        self.symbol = symbol
        self.rarity = rarity
        self.color = color
    }
    init() {}
}


struct Elements {
    
    var H = Element(
        name: "Hydrogen",
        symbol: "H",
        rarity: 100,
        color: UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0))
    
    var He = Element(
        name: "Helium",
        symbol: "He",
        rarity: 10,
        color: UIColor(red: 217/255, green: 255/255, blue: 255/255, alpha: 1.0))
    
    var Li = Element(
        name: "Lithium",
        symbol: "Li",
        rarity: 10,
        color: UIColor(red: 204/255, green: 128/255, blue: 255/255, alpha: 1.0))

    var C = Element(
        name: "Carbon",
        symbol: "C",
        rarity: 60,
        color: UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0))
    
    var N = Element(
        name: "Nitrogen",
        symbol: "N",
        rarity: 60,
        color: UIColor(red: 12/255, green: 12/255, blue: 255/255, alpha: 1.0))
    
    var O = Element(
        name: "Oxygen",
        symbol: "O",
        rarity: 60,
        color: UIColor(red: 255/255, green: 12/255, blue: 12/255, alpha: 1.0))
    
    var F = Element(
        name: "Fluorine",
        symbol: "F",
        rarity: 50,
        color: UIColor(red: 128/255, green: 179/255, blue: 255/255, alpha: 1.0))
    
    var Ne = Element(
        name: "Neon",
        symbol: "Ne",
        rarity: 10,
        color: UIColor(red: 180/255, green: 228/255, blue: 246/255, alpha: 1.0))
    
    var Na = Element(
        name: "Sodium",
        symbol: "Na",
        rarity: 50,
        color: UIColor(red: 171/255, green: 92/255, blue: 243/255, alpha: 1.0))
    
    var Mg = Element(
        name: "Magnesium",
        symbol: "Mg",
        rarity: 40,
        color: UIColor(red: 138/255, green: 255/255, blue: 0/255, alpha: 1.0))
    
    var Al = Element(
        name: "Aluminum",
        symbol: "Al",
        rarity: 50,
        color: UIColor(red: 191/255, green: 166/255, blue: 166/255, alpha: 1.0))
    
    var Si = Element(
        name: "Silicon",
        symbol: "Si",
        rarity: 50,
        color: UIColor(red: 128/255, green: 153/255, blue: 153/255, alpha: 1.0))
    
    var P = Element(
        name: "Phosphorus",
        symbol: "P",
        rarity: 50,
        color: UIColor(red: 255/255, green: 128/255, blue: 0/255, alpha: 1.0))
    
    var S = Element(
        name: "Sulfur",
        symbol: "S",
        rarity: 50,
        color: UIColor(red: 179/255, green: 179/255, blue: 0/255, alpha: 1.0))
    
    var Cl = Element(
        name: "Chlorine",
        symbol: "Cl",
        rarity: 50,
        color: UIColor(red: 30/255, green: 240/255, blue: 30/255, alpha: 1.0))
    
    var K = Element(
        name: "Potassium",
        symbol: "K",
        rarity: 50,
        color: UIColor(red: 143/255, green: 64/255, blue: 212/255, alpha: 1.0))
    
    var Ca = Element(
        name: "Calcium",
        symbol: "Ca",
        rarity: 50,
        color: UIColor(red: 61/255, green: 255/255, blue: 0/255, alpha: 1.0))
    
    var Ti = Element(
        name: "Titanium",
        symbol: "Ti",
        rarity: 20,
        color: UIColor(red: 191/255, green: 194/255, blue: 199/255, alpha: 1.0))
    
    var Cr = Element(
        name: "Chromium",
        symbol: "Cr",
        rarity: 20,
        color: UIColor(red: 138/255, green: 153/255, blue: 200/255, alpha: 1.0))

    var Fe = Element(
        name: "Iron",
        symbol: "Fe",
        rarity: 50,
        color: UIColor(red: 225/255, green: 102/255, blue: 51/255, alpha: 1.0))

    var Ni = Element(
        name: "Nickel",
        symbol: "Ni",
        rarity: 50,
        color: UIColor(red: 79/255, green: 209/255, blue: 79/255, alpha: 1.0))
    
    var Cu = Element(
        name: "Copper",
        symbol: "Cu",
        rarity: 50,
        color: UIColor(red: 199/255, green: 128/255, blue: 51/255, alpha: 1.0))
    
    var As = Element(
        name: "Arsenic",
        symbol: "As",
        rarity: 10,
        color: UIColor(red: 190/255, green: 128/255, blue: 288/255, alpha: 1.0))
    
    var Kr = Element(
        name: "Krypton",
        symbol: "Kr",
        rarity: 5,
        color: UIColor(red: 92/255, green: 184/255, blue: 209/255, alpha: 1.0))
    
    var Ag = Element(
        name: "Silver",
        symbol: "Ag",
        rarity: 5,
        color: UIColor(red: 225/255, green: 225/255, blue: 255/255, alpha: 1.0))
    
    var Sn = Element(
        name: "Tin",
        symbol: "Sn",
        rarity: 30,
        color: UIColor(red: 102/255, green: 128/255, blue: 128/255, alpha: 1.0))
    
    var I = Element(
        name: "Iodine",
        symbol: "I",
        rarity: 10,
        color: UIColor(red: 148/255, green: 0/255, blue: 148/255, alpha: 1.0))
    
    var Pt = Element(
        name: "Platinum",
        symbol: "Pt",
        rarity: 5,
        color: UIColor(red: 246/255, green: 239/255, blue: 210/255, alpha: 1.0))
    
    var Au = Element(
        name: "Gold",
        symbol: "Au",
        rarity: 3,
        color: UIColor(red: 205/255, green: 210/255, blue: 30/255, alpha: 1.0))
    
    var Hg = Element(
        name: "Mercury",
        symbol: "Hg",
        rarity: 10,
        color: UIColor(red: 181/255, green: 181/255, blue: 195/255, alpha: 1.0))
    
    var Pb = Element(
        name: "Lead",
        symbol: "Pb",
        rarity: 50,
        color: UIColor(red: 78/255, green: 81/255, blue: 88/255, alpha: 1.0))
    
    var U = Element(
        name: "Uranium",
        symbol: "U",
        rarity: 5,
        color: UIColor(red: 0/255, green: 134/255, blue: 239/255, alpha: 1.0))
    
    var Pu = Element(
        name: "Plutonium",
        symbol: "Pt",
        rarity: 5,
        color: UIColor(red: 0/255, green: 107/255, blue: 255/255, alpha: 1.0))
    
    var elementArray = [Element]()
    
    init() {
        elementArray = [H, He, Li, C, N, O, F, Ne, Na, Mg, Al, Si, P, S, Cl, K, Ca, Ti, Cr, Fe, Ni, Cu, As, Kr, Ag, Sn, I, Au, Hg, Pb, U, Pu]
    }
}


