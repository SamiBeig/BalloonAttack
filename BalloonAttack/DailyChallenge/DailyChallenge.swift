//
//  DailyChallenge.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/18/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class DailyChallenge: SKScene, SKPhysicsContactDelegate {
  

  var scoreLabel:SKLabelNode!
  var score:Int = 0{
    didSet{
      scoreLabel.text = "Score: \(score)"
    }
  }
  var gameTimer:Timer!
  var popSoundEffect: AVAudioPlayer?
  
  
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
    
    //Adding weather effects based on weatherID
    if (Singleton.weatherID >= 200 && Singleton.weatherID <= 699){
      let path = Bundle.main.path(forResource: "Rain", ofType: "sks")
      let rainDrops = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
      
      rainDrops.position = CGPoint(x: self.size.width/2, y: self.size.height )
      rainDrops.targetNode = self
      
      self.addChild(rainDrops)
    }
    
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
    
    print(Singleton.weatherID)
    
    
    
    changeBackground()

  }
  
  func startTimer(){
    counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
  }
  
  @objc func decrementCounter(){
    if timerValue < 1 {
      
      let scene = SKScene(fileNamed: "EndGame")!
      
      let transition = SKTransition.doorsOpenVertical(withDuration: 1)
      self.view?.presentScene(scene, transition: transition)
    }
    else{
      timerValue-=1
    }
  }
  
  func changeBackground(){
    switch Singleton.weatherID {
      //Thunderstorms
    case 200...399:
      self.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0, alpha: 1)
    //Drizzle
    case 300...399:
      self.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.8784313725, blue: 0.9098039216, alpha: 1)
    //Rain
    case 500...599:
      self.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.5254901961, blue: 0.968627451, alpha: 1)
    //Snow
    case 600...699:
      self.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0.6588235294, blue: 0.7176470588, alpha: 1)
    //Atmosphere
    case 700...799:
      self.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.1490196078, blue: 0.2784313725, alpha: 1)
    case 800...899:
      self.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8392156863, blue: 0.8117647059, alpha: 1)
    default:
      self.backgroundColor =  #colorLiteral(red: 0.768627451, green: 0.3843137255, blue: 0.06274509804, alpha: 1)
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

    
    let animationDuration:TimeInterval = 3
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
            popSoundEffect = try AVAudioPlayer(contentsOf: url)
            popSoundEffect?.play()
          }
          catch{
            print("couldn't find ")
          }
        }
        else{
          
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
          popSoundEffect = try AVAudioPlayer(contentsOf: url)
          popSoundEffect?.play()
        }
        catch{
          print("couldn't find sound ")
        }
      }
      
    }
    
  }
}
