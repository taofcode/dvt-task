//
//  NavBar.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import UIKit

final class NavBar: UINavigationBar {
    
    lazy var imageView = UIImageView()
    lazy var accountButton = UIButton(type: .Custom)
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        let fittingSize :CGSize = CGSize(width: self.frame.size.width, height: 100)
        return fittingSize
    }
}
