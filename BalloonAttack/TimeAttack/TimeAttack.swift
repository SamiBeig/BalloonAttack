//
//  TimeAttack.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/17/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

class TimeAttack: SKScene, SKPhysicsContactDelegate {

  var scoreLabel:SKLabelNode!
  var score:Int = 0{
    didSet{
      scoreLabel.text = "Score: \(score)"
    }
  }
  var gameTimer:Timer!
  var popSoundEffect: AVAudioPlayer?
  var boostSoundEffect: AVAudioPlayer?
  var deathSoundEffect: AVAudioPlayer?
  var gameOverMusic: AVAudioPlayer?

  //var gameOverDelegate: scoreDelegate!
  
  var timerLabel:SKLabelNode!

  var timerValue: Int = 60 {
      didSet {
          timerLabel.text = "Time left: \(timerValue)"
      }
  }
  
  var counterTimer = Timer()
  
  var balloonList = ["RedBalloon", "BlueBalloon", "YellowBalloon", "GreenBalloon", "PinkBalloon", "HealthBalloon", "DeathBalloon"]
  
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
    
    timerLabel = SKLabelNode(text: "Time left: ")
    timerLabel.position = CGPoint(x: 100, y: 465)
    timerLabel.fontName = "AmericanTypewriter-Bold"
    timerLabel.fontSize = 36
    timerLabel.fontColor = SKColor.white
    timerValue = 60
    addChild(timerLabel)
    
    
    startTimer()
    
  }
  
  func startTimer(){
    counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
  }
  
  @objc func decrementCounter(){
    if timerValue < 1 {
      
//      let path = Bundle.main.path(forResource: "GameOver", ofType: "mp3")
//      let url = URL(fileURLWithPath: path!)
//
//      do{
//        gameOverMusic = try AVAudioPlayer(contentsOf: url)
//        gameOverMusic?.play()
//      }
//      catch{
//        print("couldn't find ")
//      }
      
      let scene = SKScene(fileNamed: "EndGame")!
      
      let transition = SKTransition.doorsOpenVertical(withDuration: 1)
      self.view?.presentScene(scene, transition: transition)
      //gameOverMusic?.stop()
    }
    else{
      timerValue-=1
    }
  }
  
  
  
  @objc func addBalloons(){
    
    //Shuffling the array to get a random Balloon from assets
    balloonList = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: balloonList) as! [String]
    
    //Initialize balloon with random balloon image
    let balloon = SKSpriteNode(imageNamed: balloonList[0])
    if balloonList[0] == "HealthBalloon"{
      balloon.name = "HealthBalloon"
    }
    else if balloonList[0] == "DeathBalloon"{
      balloon.name = "DeathBalloon"
    }
    else{
      balloon.name = "balloon"
    }
    
    //random position based on screen size
    let randomBalloonPosition = GKRandomDistribution(lowestValue: -310, highestValue: 310)
    let position = CGFloat(randomBalloonPosition.nextInt())
    
    //set position of balloon
    balloon.position = CGPoint(x: position, y:self.frame.size.height + balloon.size.height)
    balloon.physicsBody = SKPhysicsBody(rectangleOf: balloon.size)
    balloon.physicsBody?.allowsRotation = false
    balloon.physicsBody?.isDynamic = false
    
    self.addChild(balloon)
    
    let animationDuration:TimeInterval = 4.5
    var actionArray = [SKAction]()
    
    actionArray.append(SKAction.move(to: CGPoint(x: position, y: -balloon.size.height - 500), duration: animationDuration))
    actionArray.append(SKAction.removeFromParent())
    
    balloon.run(SKAction.sequence(actionArray))

    
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
          print("couldn't find sound")
        }
      }
      else if touchedNode.name == "DeathBalloon"{
        touchedNode.removeFromParent()
        if timerValue >= 5{
          timerValue-=10
          let path = Bundle.main.path(forResource: "death", ofType: "wav")
          let url = URL(fileURLWithPath: path!)
          
          do{
            gameOverMusic = try AVAudioPlayer(contentsOf: url)
            gameOverMusic?.play()
          }
          catch{
            print("couldn't find ")
          }
        }
        else{
          
//
//          let path = Bundle.main.path(forResource: "GameOver", ofType: "mp3")
//          let url = URL(fileURLWithPath: path!)
//
//          do{
//            gameOverMusic = try AVAudioPlayer(contentsOf: url)
//            gameOverMusic?.play()
//          }
//          catch{
//            print("couldn't find ")
//          }
          
          let scene = SKScene(fileNamed: "EndGame")!
          
          let transition = SKTransition.doorsOpenVertical(withDuration: 1)
          self.view?.presentScene(scene, transition: transition)
          
        }

      }
      else if touchedNode.name == "HealthBalloon"{
        touchedNode.removeFromParent()
        timerValue+=3
        
        let path = Bundle.main.path(forResource: "Boost", ofType: "wav")
        let url = URL(fileURLWithPath: path!)
        
        do{
          boostSoundEffect = try AVAudioPlayer(contentsOf: url)
          boostSoundEffect?.play()
        }
        catch{
          print("couldn't find sound ")
        }
      }
      
    }
    
    
  }
}
