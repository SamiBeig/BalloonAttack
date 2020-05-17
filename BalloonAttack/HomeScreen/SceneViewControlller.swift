//
//  SceneViewControlller.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/10/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class SceneViewController: UIViewController{
  var currentScene: FreePlay?
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.navigationController?.navigationBar.barTintColor = UIColor(red: 112.0/255.0, green: 193.0/255.0, blue: 179.0/255.0, alpha: 1.0)
        
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      if let scene = SKScene(fileNamed: "FreePlay") {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        //view.removeFromSuperview()
        // Present the scene
        //view.ignoresSiblingOrder = true
        //let transition = SKTransition.moveIn(with: .right, duration: 1)
        let transition = SKTransition.doorway(withDuration: 1)
        view.presentScene(scene, transition: transition)
        //view.presentScene(scene)
        //currentScene = scene as? FreePlay
        //currentScene?.viewController = self
        view.showsNodeCount = true
        view.showsFPS = true
      }
      
    }
  }
}
