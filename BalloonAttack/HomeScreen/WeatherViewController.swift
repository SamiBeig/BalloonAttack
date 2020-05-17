//
//  Weather.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/12/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
  
  
  @IBOutlet weak var weatherLabel: UILabel!
  @IBOutlet weak var weather: UILabel!
  @IBOutlet weak var degreeLabel: UILabel!
  @IBOutlet weak var weatherID: UILabel!
  @IBOutlet weak var feelsLikeLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.navigationController?.navigationBar.barTintColor = UIColor(red: 112.0/255.0, green: 193.0/255.0, blue: 179.0/255.0, alpha: 1.0)
    weatherID.text = "Weather ID = \(Singleton.weatherID)"
    
    if Singleton.location != nil{
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
            guard let weatherDetails = json["weather"] as? [[String: Any]], let weatherMain = json["main"] as? [String: Any], let country = json["name"] as? String? else{ return }
            let weather = weatherDetails.first?["main"] as? String
            let temp = Int(weatherMain["temp"] as? Double ?? 0 )
            let feelsLikeTemp = Int(weatherMain["feels_like"] as? Double ?? 0)
            let description = (weatherDetails.first?["description"] as? String)
            let jsonID = (weatherDetails.first?["id"] as? Int ?? 0)
            
            DispatchQueue.main.async{
              self.setWeather(weatherDetails: weather, countryName: country, description: description, temp:temp, feelsLikeTemp: feelsLikeTemp, ID: jsonID )
            }
            
          }
          catch{
            print("ERROR")
          }
        }
        
        
      }
      task.resume()
      
      //self.changeBackground()
    }
    else{
      weatherLabel.text = "Could not be found"
      degreeLabel.text = "Could not be found"
      
    }
    //print(Singleton.weatherID)
    //changeBackground()
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    self.changeBackground()

  }
  
  
  
  
  func setWeather(weatherDetails: String?, countryName: String?, description: String?, temp: Int, feelsLikeTemp: Int, ID: Int){
    
    weatherLabel.text = description?.capitalizingFirstLetter() ?? "..."
    degreeLabel.text = "\(temp)° F"
    weatherID.text = "Weather ID = \(ID)"
    feelsLikeLabel.text = "Feels like \(feelsLikeTemp)° F"
    cityLabel.text = countryName
    weather.text = weatherDetails
    Singleton.weatherID = ID
    
    self.changeBackground()
    
    
  }
  
  func changeBackground(){
    switch Singleton.weatherID {
    case 200...399:
      self.view.backgroundColor = UIColor.yellow
      
    case 300...399:
      self.view.backgroundColor = UIColor.systemIndigo
      
    case 500...599:
      self.view.backgroundColor = UIColor.blue
    case 600...699:
      self.view.backgroundColor = UIColor.green
    case 700...799:
      self.view.backgroundColor = UIColor.orange
    default:
      self.view.backgroundColor = UIColor.systemGray2
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
