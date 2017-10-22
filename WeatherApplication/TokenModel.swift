//
//  TokenModel.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo

struct TokenModel {
    let token: String
    let type: String
    let expires: NSDate
    
}

// MARK: - Decodable

extension TokenModel: Fargo.Decodable {
    static func decode(json: JSON) throws -> TokenModel {
        print(json)
        let validity: NSTimeInterval = try json.value("expiresIn") / 1000
        
        
        let expires = NSDate().dateByAddingTimeInterval(validity)
        return TokenModel(
            token:		try json.value("tokenKey"),
            type:		try json.value("tokenType"),
            expires:	expires
            
        )
    }
}

// MARK: - Encodable

extension TokenModel {
    func encode() -> [String:AnyObject] {
        var json: [String:AnyObject] = [:]
        
        json["tokenKey"] = token
        json["tokenType"] = type
        json["expiresIn"] = expires.timeIntervalSinceNow * 1000
        
        return json
    }
}
