//
//  EndGame.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/17/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation


class EndGame: SKScene, SKPhysicsContactDelegate {

  
  override func didMove(to view: SKView){
    
    self.navigationController.setNavigationBarHidden(false, animated: false)
    self.navigationController?.navigationBar.barTintColor = UIColor(red: 112.0/255.0, green: 193.0/255.0, blue: 179.0/255.0, alpha: 1.0)
    
  }
  
}
