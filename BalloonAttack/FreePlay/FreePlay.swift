//
//  GameScene.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/3/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class FreePlay: SKScene, SKPhysicsContactDelegate {

  var scoreLabel:SKLabelNode!
  var score:Int = 0{
    didSet{
      scoreLabel.text = "Score: \(score)"
    }
  }
  var gameTimer:Timer!
  var popSoundEffect: AVAudioPlayer?
  

  var counterTimer = Timer()
  
  var balloonList = ["RedBalloon", "BlueBalloon", "YellowBalloon", "GreenBalloon", "PinkBalloon"]
  
  override func didMove(to view: SKView){
    
    self.physicsWorld.gravity = CGVector(dx: 0, dy:0)
    self.physicsWorld.contactDelegate = self
    
    scoreLabel = SKLabelNode(text: "Score: ")
    scoreLabel.position = CGPoint(x: -180, y: 465)
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
    
    //Initialize balloon with random balloon image
    let balloon = SKSpriteNode(imageNamed: balloonList[0])
    balloon.name = "balloon"
    
    let deathBalloon = SKSpriteNode(imageNamed: "DeathBalloon")
    deathBalloon.name = "deathBalloon"
    
    //random position based on screen size
    let randomBalloonPosition = GKRandomDistribution(lowestValue: -310, highestValue: 310)
    let position = CGFloat(randomBalloonPosition.nextInt())
    
    let randomBalloonPosition2 = GKRandomDistribution(lowestValue: -310, highestValue: 310)
    let position2 = CGFloat(randomBalloonPosition2.nextInt())
    
    //set position of balloon
    balloon.position = CGPoint(x: position, y:self.frame.size.height + balloon.size.height)
    balloon.physicsBody = SKPhysicsBody(rectangleOf: balloon.size)
    balloon.physicsBody?.allowsRotation = false
    balloon.physicsBody?.isDynamic = false
    
    deathBalloon.position = CGPoint(x: position2, y:self.frame.size.height + deathBalloon.size.height)
    deathBalloon.physicsBody = SKPhysicsBody(rectangleOf: deathBalloon.size)
    deathBalloon.physicsBody?.allowsRotation = false
    deathBalloon.physicsBody?.isDynamic = false
    
    self.addChild(balloon)
    self.addChild(deathBalloon)
    
    let animationDuration:TimeInterval = 4.5
    var actionArray = [SKAction]()
    
    actionArray.append(SKAction.move(to: CGPoint(x: position, y: -balloon.size.height - 500), duration: animationDuration))
    actionArray.append(SKAction.removeFromParent())
    
    balloon.run(SKAction.sequence(actionArray))
    deathBalloon.run(SKAction.sequence(actionArray))
    
  }
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
    /* Called when a touch begins */
    
    for touch in touches {
      let location = touch.location(in: self)
      let touchedNode = self.atPoint(location)
      
      if touchedNode.name == "balloon"{
        touchedNode.removeFromParent()
        score+=5
        
        let path = Bundle.main.path(forResource: "BalloonPop", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        
        do{
          popSoundEffect = try AVAudioPlayer(contentsOf: url)
          popSoundEffect?.play()
        }
        catch{
          print("couldn't find ")
        }
      }
      else if touchedNode.name == "deathBalloon"{
        touchedNode.removeFromParent()
        
        let path = Bundle.main.path(forResource: "GameOver", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        
        do{
          popSoundEffect = try AVAudioPlayer(contentsOf: url)
          popSoundEffect?.play()
        }
        catch{
          print("couldn't find ")
        }
        
        let scene = SKScene(fileNamed: "EndGame")!
        
        let transition = SKTransition.doorway(withDuration: 1)
        self.view?.presentScene(scene, transition: transition)
        
        print("END GAME")
      }
      
    }
    
    
  }
}
