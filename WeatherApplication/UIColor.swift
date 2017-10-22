//
//  UIColor.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//
//

import Foundation
import Fargo
import UIKit

extension UIColor {
    
    //MARK: - Init
    
    public convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(hex: Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
    public convenience init(hexString: String) {
        guard let hexInt = Int(hexString, radix: 16) else {
            self.init(red: 0, green: 0, blue: 0)
            return
        }
        self.init(hex: hexInt)
    }
}
