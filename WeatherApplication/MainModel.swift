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
    public let temp: String?
    public let pressure: String?
    public let humidity: String?
    public let temp_min : String?
    public let temp_max : String?
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
