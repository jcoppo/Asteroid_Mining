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
    //for determining if used
    var minNum = CGFloat()
    var maxNum = CGFloat()
    // this is the quantity of the element, in an arbitrary "unit"
    var amount = 0
    //
    init(name: String, symbol: String, rarity: CGFloat) {
        self.name = name
        self.symbol = symbol
        self.rarity = rarity
    }
    init() {}
}


struct Elements {
    
    var H = Element(name: "Hydrogen", symbol: "H", rarity: 100)
    var He = Element(name: "Helium", symbol: "He", rarity: 10)
    var Li = Element(name: "Lithium", symbol: "Li", rarity: 10)
    var Be = Element(name: "Beryllium", symbol: "Be", rarity: 5)
    var B = Element(name: "Boron", symbol: "B", rarity: 10)
    var C = Element(name: "Carbon", symbol: "C", rarity: 60)
    var N = Element(name: "Nitrogen", symbol: "N", rarity: 60)
    var O = Element(name: "Oxygen", symbol: "O", rarity: 60)
    var F = Element(name: "Fluorine", symbol: "F", rarity: 50)
    var Ne = Element(name: "Neon", symbol: "Ne", rarity: 10)
    var Na = Element(name: "Sodium", symbol: "Na", rarity: 50)
    var Mg = Element(name: "Magnesium", symbol: "Mg", rarity: 40)
    var Al = Element(name: "Aluminum", symbol: "Al", rarity: 50)
    var Si = Element(name: "Silicon", symbol: "Si", rarity: 50)
    var P = Element(name: "Phosphorus", symbol: "P", rarity: 50)
    var S = Element(name: "Sulfur", symbol: "S", rarity: 50)
    var Cl = Element(name: "Chlorine", symbol: "Cl", rarity: 50)
    var Ar = Element(name: "Argon", symbol: "Ar", rarity: 10)
    var K = Element(name: "Potassium", symbol: "K", rarity: 50)
    var Ca = Element(name: "Calcium", symbol: "Ca", rarity: 50)
    var Ti = Element(name: "Titanium", symbol: "Ti", rarity: 20)
    var Cr = Element(name: "Chromium", symbol: "Cr", rarity: 20)
    var Mn = Element(name: "Mangansese", symbol: "Mn", rarity: 20)
    var Fe = Element(name: "Iron", symbol: "Fe", rarity: 50)
    var Co = Element(name: "Cobalt", symbol: "Co", rarity: 30)
    var Ni = Element(name: "Nickel", symbol: "Ni", rarity: 50)
    var Cu = Element(name: "Copper", symbol: "Cu", rarity: 50)
    var Zn = Element(name: "Zinc", symbol: "Zn", rarity: 30)
    var As = Element(name: "Arsenic", symbol: "As", rarity: 10)
    var Kr = Element(name: "Krypton", symbol: "Kr", rarity: 5)
    var Ag = Element(name: "Silver", symbol: "Ag", rarity: 5)
    var Sn = Element(name: "Tin", symbol: "Sn", rarity: 30)
    var I = Element(name: "Iodine", symbol: "I", rarity: 10)
    var Pt = Element(name: "Platinum", symbol: "Pt", rarity: 5)
    var Au = Element(name: "Gold", symbol: "Au", rarity: 3)
    var Hg = Element(name: "Mercury", symbol: "Hg", rarity: 10)
    var Pb = Element(name: "Lead", symbol: "Pb", rarity: 50)
    var U = Element(name: "Uranium", symbol: "U", rarity: 5)
    var Pu = Element(name: "Plutonium", symbol: "Pt", rarity: 5)
    
    var elementArray = [Element]()
    
    init() {
        elementArray = [H, He, Li, Be, B, C, N, O, F, Ne, Na, Mg, Al, Si, P, S, Cl, Ar, K, Ca, Ti, Cr, Mn, Fe, Co, Ni, Cu, Zn, As, Kr, Ag, Sn, I, Au, Hg, Pb, U, Pu]
    }
}


