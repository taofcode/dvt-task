//
//  SysModel.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo
public struct SysModel {
    public let type: String?
    public let id: String?
    public let message: String?
    public let country : String?
    public let sunrise : String?
    public let sunset : String?
}

extension SysModel: Fargo.Decodable {
    public static func decode(json: JSON) throws -> SysModel {
        return SysModel(
            type:	try json.value("type"),
            id:	try json.value("id"),
            message : try json.value("message"),
            country : try json.value("country"),
            sunrise : try json.value("sunrise"),
            sunset : try json.value("sunset")
            
        )
    }
}
