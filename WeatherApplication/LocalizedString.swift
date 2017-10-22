//
//  LocalizedString.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation

public func LS(key: String, comment: String = "") -> String {
    let mainBundleString = NSLocalizedString(key, comment: comment)
    if mainBundleString != key {
        return mainBundleString
    } else {
        let uiString = NSBundle(forClass: HomePageViewController.classForCoder()).localizedStringForKey(key, value: "", table: nil)
        guard uiString.characters.count > 0 else {
            return mainBundleString
        }
        return uiString
    }
}
