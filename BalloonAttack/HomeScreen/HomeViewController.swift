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
import CoreLocation

class HomeViewController: UIViewController{

  
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


}

class Singleton {
  
  static var weatherID = 200
    
  // Make init method private
  
  private init() {
    Singleton.weatherID = 200
  }
  
  func updateID(updatedID: Int){
    Singleton.weatherID = updatedID
  }
  
}




