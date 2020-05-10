//
//  InfoButtonViewController.swift
//  BalloonAttack
//
//  Created by Sami Beig on 5/3/20.
//  Copyright © 2020 Sami Beig. All rights reserved.
//

//tint color

import UIKit

class InfoButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.navigationController?.setNavigationBarHidden(false, animated: false)
      self.navigationController?.navigationBar.barTintColor = UIColor(red: 112.0/255.0, green: 193.0/255.0, blue: 179.0/255.0, alpha: 1.0)


    }
    

}
