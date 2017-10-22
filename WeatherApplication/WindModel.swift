//
//  WindModel.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo

public struct WindModel {
    public let speed: String?
    public let deg: String?
}

extension WindModel: Fargo.Decodable {
    public static func decode(json: JSON) throws -> WindModel {
        return WindModel(
            speed:	try json.value("speed"),
            deg:	try json.value("deg")
        )
    }
}
