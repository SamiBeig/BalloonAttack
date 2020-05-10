//
//  GameScene.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/3/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import SpriteKit
import GameplayKit

class FreePlay: SKScene {
  weak var viewController: HomeViewController?
  private var label : SKLabelNode?
  private var spinnyNode : SKShapeNode?
  
  /*
   override func didMove(to view: SKView) {
   
   // Get label node from scene and store it for use later
   self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
   if let label = self.label {
   label.alpha = 0.0
   label.run(SKAction.fadeIn(withDuration: 2.0))
   }
   
   }
   */
  
  override func sceneDidLoad() {
    // Get label node from scene and store it for use later
    self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
    if let label = self.label {
      label.alpha = 0.0
      label.run(SKAction.fadeIn(withDuration: 2.0))
    }
  }
  
  
  
}
