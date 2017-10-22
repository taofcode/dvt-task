//
//  CloudModel.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo

public struct CloudModel {
    public let all: Float?
 
}

extension CloudModel: Fargo.Decodable {
    public static func decode(json: JSON) throws -> CloudModel {
        return CloudModel(
            all :	try json.value("all")
        )
    }
}
