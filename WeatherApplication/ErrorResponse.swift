//
//  ErrorResponse.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo
struct ErrorResponse {
    let errorCode: String
    let description: String
    let error: String!
    let errorDescription: String!
    let errorDisplay: String!
    
}

extension ErrorResponse: Fargo.Decodable {
    static func decode(json: JSON) throws -> ErrorResponse {
        return ErrorResponse(
            errorCode:		try json.value("errorCode"),
            description:	try json.value("description"),
            error:		try json.value("error"),
            errorDescription:	try json.value("errorDescription"),
            errorDisplay:	try json.value("errorDisplay")
        )
    }
}
