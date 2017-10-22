//
//  CodeResponse.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo

struct CodeResponse {
    var responseCode: String
    var description: String
}

extension CodeResponse: Fargo.Decodable {
    static func decode(json: JSON) throws -> CodeResponse {
        
        return CodeResponse(
            responseCode:        try json.value("responseCode"),
            description:         try json.value("description")
            
        )
    }
}
