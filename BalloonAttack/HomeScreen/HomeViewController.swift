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

protocol gameModeDelegate{
  func tapped(name: String)
}

class HomeViewController: UIViewController, CLLocationManagerDelegate{
  
  let locationManager = CLLocationManager()
  var isUpdatingLocation = false
  var selectedGameMode:gameModeDelegate?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    
    /*
    let authorizationStatus = CLLocationManager.authorizationStatus()
    if authorizationStatus == .notDetermined{
      locationManager.requestWhenInUseAuthorization()
    }
    
    if authorizationStatus == .denied || authorizationStatus == .restricted{
      let alert = UIAlertController(title: "Please change your location settings for this app!",  message:"Please go to Settings -> Privary and fix this!", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil )
      alert.addAction(okAction)
      
      present(alert, animated: true, completion: nil)
      
    }
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.startUpdatingLocation()
    isUpdatingLocation = true
    */
    
  }
  
  @IBAction func freePlay(_ sender: Any) {
    selectedGameMode?.tapped(name: "FreePlay")
  }
  
  @IBAction func timeAttack(_ sender: Any) {
    selectedGameMode?.tapped(name: "TimeAttack")
  }
  
  @IBAction func dailyChallenge(_ sender: Any) {
    selectedGameMode?.tapped(name: "DailyChallenge")
  }
  
  @IBAction func checkWeather(_ sender: Any) {    
    
    let authorizationStatus = CLLocationManager.authorizationStatus()
    if authorizationStatus == .notDetermined{
      locationManager.requestWhenInUseAuthorization()
    }
    
    if authorizationStatus == .denied || authorizationStatus == .restricted{
      let alert = UIAlertController(title: "Please change your location settings for this app!",  message:"Please go to Settings -> Privary and fix this!", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil )
      alert.addAction(okAction)
      
      present(alert, animated: true, completion: nil)
      
    }
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.startUpdatingLocation()
    isUpdatingLocation = true
  }
  
  
  
  
  @objc func didTimeOut(){
    print("Time out")
  }
  
  func locationManager(_ manager: CLLocationManager,
                       didFailWithError error: Error) {
    print("didFailWithError \(error.localizedDescription)")
  }
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation]) {
    Singleton.location = locations.last!
    //print("didUpdateLocations \(newLocation)")
  }
  
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    
  }
  
  
  
  
  
  
  
  
}




class Singleton {
  
  static var weatherID = 200
  static var location:CLLocation?
  
  // Make init method private
  
  private init() {
    Singleton.weatherID = 200
  }
  
  func updateID(updatedID: Int){
    Singleton.weatherID = updatedID
  }
  
}




