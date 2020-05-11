//
//  GameScene.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/3/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import SpriteKit
import GameplayKit

class FreePlay: SKScene, SKPhysicsContactDelegate {
  //private var label : SKLabelNode?
  //private var spinnyNode : SKShapeNode
  
  var scoreLabel:SKLabelNode!
  var score:Int = 0{
    didSet{
      scoreLabel.text = "Score: \(score)"
    }
  }
  var gameTimer:Timer!
  
  var balloonList = ["RedBalloon", "BlueBalloon", "LightBlueBalloon", "GreenBalloon", "PinkBalloon"]
  
  override func didMove(to view: SKView){
    
    self.physicsWorld.gravity = CGVector(dx: 0, dy:0)
    self.physicsWorld.contactDelegate = self
    
    scoreLabel = SKLabelNode(text: "Score: ")
    scoreLabel.position = CGPoint(x: -175, y: 550)
    scoreLabel.fontName = "AmericanTypewriter-Bold"
    scoreLabel.fontSize = 36
    scoreLabel.fontColor = UIColor.white
    score = 0
    self.addChild(scoreLabel)
    
    gameTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector:#selector(addBalloons), userInfo: nil, repeats: true)
    
  }
  
  @objc func addBalloons(){
    
    //Shuffling the array to get a random Balloon from assets
    balloonList = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: balloonList) as! [String]
    
    //Initialize balloon with random balloon
    let balloon = SKSpriteNode(imageNamed: balloonList[0])
    
    //random position based on screen size
    let randomBalloonPosition = GKRandomDistribution(lowestValue: -320, highestValue: 320)
    let position = CGFloat(randomBalloonPosition.nextInt())
    
    //set position of balloon
    balloon.position = CGPoint(x: position, y:self.frame.size.height + balloon.size.height)
    balloon.physicsBody = SKPhysicsBody(rectangleOf: balloon.size)
    balloon.physicsBody?.isDynamic = true
    
    self.addChild(balloon)
    
    let animationDuration:TimeInterval = 6
    var actionArray = [SKAction]()
    actionArray.append(SKAction.move(to: CGPoint(x: position, y: -balloon.size.height - 500), duration: animationDuration))
    actionArray.append(SKAction.removeFromParent())
    
    balloon.run(SKAction.sequence(actionArray))
    
  }
  
  
  /*
  override func sceneDidLoad() {
    // Get label node from scene and store it for use later
    self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
    if let label = self.label {
      label.alpha = 0.0
      label.run(SKAction.fadeIn(withDuration: 2.0))
    }
  }
 */
  
  
  
}
