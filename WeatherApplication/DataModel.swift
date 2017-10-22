//
//  DataModel.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo

public struct DataModel {
 
       let coord: CoordModel
    let weather: [WeatherModel]
    let baseStation : String
    let main : MainModel
    let visibility : String?
     let wind: WindModel
     let clouds: String
     let dt : String
    let sys : SysModel
    let id : String
    let name : String
    let code : String

   }

// MARK: - Decodable

extension DataModel: Fargo.Decodable {
    public static func decode(json: JSON) throws -> DataModel {
        
        print(json)
        return DataModel(
            coord:	try json.value("coord"),
            weather: try json.value("weather"),
            baseStation:	try json.value("baseStation"),
            main : try json.value("main"),
            visibility : try json.value("visibility"),
            wind : try json.value("wind"),
            clouds : try json.value("clouds"),
            dt : try json.value("dt"),
            sys : try json.value("sys"),
            id : try json.value("id"),
            name: try json.value("name"),
            code : try json.value("code")
            
        )
        
        
    }
}
