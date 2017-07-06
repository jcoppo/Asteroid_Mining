//
//  ShopButtonView.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 7/5/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//

import UIKit

class ShopButtonView: UIView {
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.3, green: 1.0, blue: 0.3, alpha: 1.0)
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        label.text = "SHOP"
        label.textColor = UIColor.white
        label.font = UIFont(name: Font.arial, size: 20)
        label.textAlignment = .center
        addSubview(label)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(tapGesture)
        
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        
        print("booooooo")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
