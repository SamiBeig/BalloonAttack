//
//  EndGame.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/17/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation



class EndGame: SKScene {
  
  var finalScore: Int = 0
  var gameOver = SKLabelNode(text: "GAME OVER!")

  
  
  override func didMove(to view: SKView) {
    print(finalScore)
    
    gameOver.text = "GAME OVER!"
    gameOver.position = CGPoint(x: -180, y: 465)
    gameOver.fontName = "AmericanTypewriter-Bold"
    gameOver.fontSize = 36
    gameOver.fontColor = UIColor.red
    self.addChild(gameOver)

  }

}
