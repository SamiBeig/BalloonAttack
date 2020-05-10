//
//  ViewController.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/1/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class HomeViewController: UIViewController{
  //var currentScene: FreePlay?
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = UIColor.red
    //elf.view.backgroundColor = UIColor.blue
    //view.backgroundColor = .black
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)

  }
  
  @IBAction func freePlay(_ sender: Any) {
    //var currentScene: FreePlay?
    /*
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      if let scene = SKScene(fileNamed: "FreePlay") {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        //view.removeFromSuperview()
        // Present the scene
        view.ignoresSiblingOrder = true

        view.presentScene(scene)
        currentScene = scene as? FreePlay
        currentScene?.viewController = self
        
      }
      */
      //scene.scaleMode = .aspectFill
      
      //view.removeFromSuperview()
      // Present the scene
      //let scene = SKScene(fileNamed: "FreePlay")
      //view.presentScene(scene)
      //currentScene = scene as? FreePlay
      //currentScene?.viewController = self
      
      
    }
  }
  
  

