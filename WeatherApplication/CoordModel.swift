//
//  CoordModel.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo

public struct CoordModel {
    public let lon: String?
    public let lat: String?
}

extension CoordModel: Fargo.Decodable {
    public static func decode(json: JSON) throws -> CoordModel {
        return CoordModel(
            lon:	try json.value("lon"),
            lat:	try json.value("lat")
        )
    }
}
