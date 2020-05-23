//
//  DailyViewController.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/18/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class DailyViewController: UIViewController{
  
  var currentScene:String? = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    
    self.navigationController?.setNavigationBarHidden(false, animated: false)

    
    if Singleton.location != nil && Singleton.weatherID == 100{
      let urlBeginning = "https://api.openweathermap.org/data/2.5/weather?"
      let lat = "lat=\(Singleton.location!.coordinate.latitude)"
      let lon =  "&lon=\(Singleton.location! .coordinate.longitude)&units=imperial"
      let apiKey = API_KEY
      
      let temp = urlBeginning + lat + lon + apiKey
      print(temp)
      
      guard let url = URL(string: urlBeginning + lat + lon + apiKey) else { return }
      
      let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
        if let data = data, error == nil {
          do{
            guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else{ return}
            guard let weatherDetails = json["weather"] as? [[String: Any]] else{ return }
            let jsonID = (weatherDetails.first?["id"] as? Int ?? 0)
            
            DispatchQueue.main.async{
              Singleton.weatherID = jsonID
            }
            
          }
          catch{
            print("ERROR")
          }
        }
        
        
      }
      task.resume()
      
      changeBackground()
    }
    
    if let view = self.view as! SKView? {
      
      // Load the SKScene from 'FreePlay.sks'
      //if let currentScene = "TimeAttack"{
      if let scene = SKScene(fileNamed: "DailyChallenge") {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        // Present the scene
        //view.ignoresSiblingOrder = true
        //let transition = SKTransition.moveIn(with: .right, duration: 1)
        let transition = SKTransition.doorway(withDuration: 1)
        view.presentScene(scene, transition: transition)
        //view.presentScene(scene)
        view.showsNodeCount = true
        view.showsFPS = true
      }
      //}
    }
  }
  
  
  func changeBackground(){
    switch Singleton.weatherID {
    //Thunderstorms
    case 200...399:
      self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0, alpha: 1)
      self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.9058823529, blue: 0, alpha: 1)
    //Drizzle
    case 300...399:
      self.view.backgroundColor = #colorLiteral(red: 0.5843137255, green: 0.8784313725, blue: 0.9098039216, alpha: 1)
      self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5843137255, green: 0.8784313725, blue: 0.9098039216, alpha: 1)
    //Rain
    case 500...599:
      self.view.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.5254901961, blue: 0.968627451, alpha: 1)
      self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.3098039216, green: 0.5254901961, blue: 0.968627451, alpha: 1)
    //Snow
    case 600...699:
      self.view.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0.6588235294, blue: 0.7176470588, alpha: 1)
      self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5450980392, green: 0.6588235294, blue: 0.7176470588, alpha: 1)
    //Atmosphere
    case 700...799:
      self.view.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.1490196078, blue: 0.2784313725, alpha: 1)
      self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.8549019608, green: 0.1490196078, blue: 0.2784313725, alpha: 1)
      
    case 800...899:
      self.view.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8392156863, blue: 0.8117647059, alpha: 1)
      self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.8509803922, green: 0.8392156863, blue: 0.8117647059, alpha: 1)
    default:
      self.view.backgroundColor =  #colorLiteral(red: 0.768627451, green: 0.3843137255, blue: 0.06274509804, alpha: 1)
      self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.768627451, green: 0.3843137255, blue: 0.06274509804, alpha: 1)
    }
  }
}
