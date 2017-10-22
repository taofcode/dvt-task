//
//  Theme.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo

/**
	Setup global theme appearance.
 */
public func setupThemeAppearance() {
    UINavigationBar.appearance().translucent = false
    UINavigationBar.appearance().barTintColor = Theme.current.color(.navBarColor)
    UINavigationBar.appearance().tintColor = Theme.current.color(.navBarTintColor)
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: Theme.current.color(.navBarTintColor)]
}


// MARK: - Theme



public struct Theme {
    private var colors: [Color: UIColor] = [:]
    
    public static let current = Theme()
    
    init() {
        guard let jsonPath = NSBundle.mainBundle().pathForResource("Theme", ofType: "json") else {
                   return
        }
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {
             return
        }
        
        do {
            let jsonObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments)
            let json = JSON.convert(jsonObject)
            self.colors = try Theme.decodeColors(json)
        } catch {
                }
    }
    
    static func decodeColors(json: JSON) throws -> [Color: UIColor] {
        guard case .Object(let jsonObject) = json else {
            throw DecodeError.TypeMismatch("Expected an Object, got `\(json)` instead")
        }
        guard let dict = jsonObject["colors"], case .Object(let obj) = dict else {
            throw DecodeError.TypeMismatch("Expected an Object, got `\(jsonObject)` instead")
        }
        
        let colors = try obj.reduce([:], combine: { (r, el) -> [Color: UIColor] in
            guard let key = Color(rawValue: el.0) else {
                throw DecodeError.TypeMismatch("Expected a valid Color string, got `\(el.0)` instead")
            }
            let hexString: String = try el.1.decode()
            let val = UIColor(hexString: hexString)
            var result = r
            result[key] = val
            return result
        })
        
        return colors
    }
}

extension Theme {
    public enum Color: String, Fargo.Decodable {
        case navBarColor                    = "navBarColor"
        case navBarTintColor                = "navBarTintColor"
        case buttonBackgroundColor          = "buttonBackgroundColor"
        case buttonTextColor                = "buttonTextColor"
        case buttonBackgroundColorSecondary = "buttonBackgroundColorSecondary"
        case buttonTextColorSecondary       = "buttonTextColorSecondary"
        case textColor                      = "textColor"
        case backgroundColor                = "backgroundColor"
        case textFieldBorderColor			= "textFieldBorderColor"
        case menuItemColor                  = "menuItemColor"
        case menuItemSubColor               = "menuItemSubColor"
        case textColorLanding               = "textColorLanding"
        case textSubColor                   = "textSubColor"
        case connectTextColor               = "connectTextColor"
        case titleheader                    = "titleheader"
        case contactTextColor               = "contactTextColor"
        case sliderColor                    = "sliderColor"
        case sectionBG                      = "sectionBG"
        
        public static func decode(json: JSON) throws -> Color {
            if case .String(let str) = json, let clr = Color(rawValue: str) {
                return clr
            }
            throw Fargo.DecodeError.TypeMismatch("Expected string got: \(json)")
        }
    }
}


// MARK: - Public interface

extension Theme {
    public func color(color: Color) -> UIColor {
        guard let c = colors[color] else {
                return .blackColor()
        }
        return c
    }
}
