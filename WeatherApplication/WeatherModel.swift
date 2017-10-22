//
//  WeatherModel.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo
public struct WeatherModel {
    public let id: Float?
    public let main: String?
    public let description : String?
    public let icon : String?
}

extension WeatherModel: Fargo.Decodable {
    public static func decode(json: JSON) throws -> WeatherModel {
        return WeatherModel(
            id:	try json.value("id"),
            main:	try json.value("main"),
            description:	try json.value("description"),
            icon:	try json.value("icon")
        )
    }
}
