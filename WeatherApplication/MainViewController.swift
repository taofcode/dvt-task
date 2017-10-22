//
//  MainViewController.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import UIKit

class MainViewController: UIViewController ,UITextFieldDelegate{
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.current.color(.backgroundColor)
        
        
        label.text = "Hello"
     
        view.addSubview(label)
    }
    
}
