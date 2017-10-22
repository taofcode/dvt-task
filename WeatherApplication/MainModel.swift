//
//  MainModel.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo

public struct MainModel {
    public let temp: Float?
    public let pressure: Float?
    public let humidity: Float?
    public let temp_min : Float?
    public let temp_max : Float?
}

extension MainModel: Fargo.Decodable {
    public static func decode(json: JSON) throws -> MainModel {
        return MainModel(
            temp:	try json.value("temp"),
            pressure:	try json.value("pressure"),
            humidity : try json.value("humidity"),
            temp_min : try json.value("temp_min"),
            temp_max : try json.value("temp_max")
            
        )
    }
}
