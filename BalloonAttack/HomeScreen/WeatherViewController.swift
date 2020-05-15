//
//  Weather.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/12/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
  
  let locationManager = CLLocationManager()
  var location: CLLocation?
  var isUpdatingLocation = false
  var timer:Timer!
  
  @IBOutlet weak var weatherLabel: UILabel!
  
  @IBOutlet weak var degreeLabel: UILabel!
  @IBOutlet weak var weatherID: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.navigationController?.navigationBar.barTintColor = UIColor(red: 112.0/255.0, green: 193.0/255.0, blue: 179.0/255.0, alpha: 1.0)
    weatherID.text = "Weather ID = \(Singleton.weatherID)"
    
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
    
    refresh([])
    
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
    location = locations.last!
    //print("didUpdateLocations \(newLocation)")
  }
  
  func setWeather(description: String?, temp: Int, ID: Int){
    weatherLabel.text = description?.capitalizingFirstLetter() ?? "..."
    degreeLabel.text = "\(temp)° F"
    weatherID.text = "Weather ID = \(ID)"
    
    
  }
  
  
  @IBAction func refresh(_ sender: Any) {
    if let location = location{
      
      let urlBeginning = "https://api.openweathermap.org/data/2.5/weather?"
      let lat = "lat=\(location.coordinate.latitude)"
      let lon =  "&lon=\(location.coordinate.longitude)&units=imperial"
      let apiKey = API_KEY
      
      let temp = urlBeginning + lat + lon + apiKey
      print(temp)
      
      guard let url = URL(string: urlBeginning + lat + lon + apiKey) else { return }
      
      let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
        if let data = data, error == nil {
          do{
            guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else{ return}
            guard let weatherDetails = json["weather"] as? [[String: Any]], let weatherMain = json["main"] as? [String: Any] else{ return }
            let temp = Int(weatherMain["temp"] as? Double ?? 0 )
            let description = (weatherDetails.first?["description"] as? String)
            let jsonID = (weatherDetails.first?["id"] as? Int ?? 0)
            DispatchQueue.main.async{
              self.setWeather(description: description, temp:temp, ID: jsonID )
            }
          }
          catch{
            print("ERROR")
          }
        }
        
        
      }
      task.resume()
      
    }
  }
  
  
}


// https://www.hackingwithswift.com/example-code/strings/how-to-capitalize-the-first-letter-of-a-string
extension String {
  func capitalizingFirstLetter() -> String {
    return prefix(1).capitalized + dropFirst()
  }
  
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }
}
