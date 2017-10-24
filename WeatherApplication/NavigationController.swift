//
//  NavigationController.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import UIKit

final public class NavigationController: UINavigationController {
    
    override public init(rootViewController: UIViewController) {
        super.init(navigationBarClass: NavBar.self, toolbarClass: nil)
        pushViewController(rootViewController, animated: false)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Rotation support

extension NavigationController {
    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
}

