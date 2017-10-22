//
//  BoostrapUI.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//


import UIKit

/**
 Sets up root view controller on main window initially. If rootViewController is passed as an argument it uses that one.
 Otherwise it will create a standard MenuViewController and use that.
 */
public func bootstrapUI(rootViewController: UIViewController? = nil) {
    // Sanity
     guard let window = UIApplication.sharedApplication().keyWindow else { fatalError("Key window not found") }
    
 
        let viewController = NavigationController(rootViewController: rootViewController!)
        window.rootViewController = viewController
    }


