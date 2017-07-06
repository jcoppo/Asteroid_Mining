//
//  GameViewController.swift
//  Asteroid Mining
//
//  Created by Jayson Coppo on 6/21/17.
//  Copyright © 2017 Jayson Coppo. All rights reserved.
//
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //    let myArray: NSArray = ["First","Second","Third"]
    let shoppingList = ShoppingList()
    var shoppingView = UIView()
    var myTableView: UITableView!
    var shopButton = ShopButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewControllers.gameVC = self
        
        if let view = self.view as! SKView? {
            
            CurrentArea.name = "Play Room"
            
            let scene = OverWorldScene()
            scene.size = CGSize(width: 750, height: 1334)
            print(view.frame.size)
            
            scene.scaleMode = SKSceneScaleMode.aspectFill
            
            view.presentScene(scene)
        }
        
        shopButton = ShopButtonView(frame: CGRect(x: 20, y: 10, width: 60, height: 30))
        
        shoppingView = UIView(frame: CGRect(x: 0, y: 40, width: view.frame.width, height: view.frame.height-40))
        shoppingView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        
        myTableView = UITableView(frame: CGRect(x: shoppingView.frame.width*0.4, y: 0, width: shoppingView.frame.width*0.6, height: shoppingView.frame.height))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.rowHeight = 150
        myTableView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        shoppingView.addSubview(myTableView)
    }
    
    func addPlayroomButtons() {
        
        view.addSubview(shopButton)

    }
    
    func removePlayroomButtons() {
        
        shopButton.removeFromSuperview()
    }
    
    func showTable() {
        view.addSubview(shoppingView)
    }
    
    func removeTable() {
        shoppingView.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(shoppingList.itemsArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let shopItem = shoppingList.itemsArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        cell.backgroundColor = UIColor.clear
        
        let title = UILabel(frame: CGRect(x: 15, y: 10, width: cell.frame.width, height: 30))
        title.text = shopItem.name
        title.font = UIFont(name: Font.font, size: 25)
        title.textColor = UIColor.white
        
        let pic = UIImageView(frame: CGRect(x: 15, y: 50, width: 60, height: 60))
        pic.image = UIImage(named: "pic")
        pic.backgroundColor = UIColor.orange
        
        var n = 0
            
        for cost in shopItem.costElements {
            
            print("\(cost.element.name), \(cost.cost)")
            
            let label = UILabel(frame: CGRect(x: 80, y: 50 + CGFloat(n)*20, width: cell.frame.width, height: 20))
            label.text = "\(cost.cost) \(cost.element.name)"
            label.font = UIFont(name: Font.font, size: 15)
            label.textColor = cost.element.color
            cell.addSubview(label)
            
            n += 1
        }
        
        cell.addSubview(title)
        cell.addSubview(pic)
        
        return cell
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
