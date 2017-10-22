//
//  MainViewController.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import UIKit

final public class MainViewController: UINavigationController{
    let label = UILabel()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.current.color(.backgroundColor)
        
        
        label.text = "Hello"
     
        view.addSubview(label)
    }
    
    
    
}
extension MainViewController{

    func didPressRefreshButton(sender:AnyObject){}
    

}

