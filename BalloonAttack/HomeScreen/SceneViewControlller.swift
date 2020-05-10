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
        
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      if let scene = SKScene(fileNamed: "FreePlay") {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        //view.removeFromSuperview()
        // Present the scene
        //view.ignoresSiblingOrder = true
        
        view.presentScene(scene)
        //currentScene = scene as? FreePlay
        //currentScene?.viewController = self
        
      }
      
    }
  }
}
