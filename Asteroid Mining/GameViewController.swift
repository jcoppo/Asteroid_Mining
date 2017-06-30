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
    
    let myArray: NSArray = ["First","Second","Third"]
    var myTableView: UITableView!

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
        
        myTableView = UITableView(frame: CGRect(x: view.frame.width/4, y: 100, width: view.frame.width*3/4, height: view.frame.height))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.rowHeight = 100
        myTableView.backgroundColor = UIColor.clear
//        self.view.addSubview(myTableView)
    
    }
    
    func showTable() {
        view.addSubview(myTableView)
    }
    
    func removeTable() {
        myTableView.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        cell.backgroundColor = UIColor.clear
        
        let title = UILabel(frame: CGRect(x: 15, y: 10, width: 80, height: 20))
        title.text = "The Thing"
        title.textColor = UIColor.white
        
        let pic = UIImageView(frame: CGRect(x: 15, y: 30, width: 60, height: 60))
        pic.image = UIImage(named: "pic")
        pic.backgroundColor = UIColor.orange
        
        
        
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
