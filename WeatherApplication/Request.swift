//
//  Request.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Alamofire
import Fargo

extension Request {
    public static func APIJSONResponseSerializer() -> ResponseSerializer<AnyObject, NSError> {
        return ResponseSerializer { request, response, data, validationError in
            let result = JSONResponseSerializer().serializeResponse(request, response, data, nil)
            
            // First check if we got 401 unauthorized
            if let response = response where response.statusCode == 401 {
                //log?.error("API request unauthorized: \(response)")
                let error = NSError(domain: Networking.Error.Domain, code: Networking.Error.Code.Unauthorized.rawValue, userInfo: nil)
                return .Failure(error)
            }
            
            if result.error != nil {
                //log?.error("JSON response deserialization error: \(deserializationError). Response: \(response), data: \(data)")
                let error = NSError(domain: Networking.Error.Domain, code: Networking.Error.Code.ParsingError.rawValue, userInfo: nil)
                return .Failure(error)
            }
            if let validationError = validationError {
                do {
                    let errorResponse: ErrorResponse = try JSON.convert(result.value!).decode()
                    let finalError = NSError(domain: Networking.Error.ThundrCraftDomain, code: Int(errorResponse.errorCode) ?? -1, userInfo: [NSLocalizedDescriptionKey: errorResponse.description])
                    return .Failure(finalError)
                } catch {
                    
                    // Check inconsistent error structure also
                    if let dict = result.value as? [String: AnyObject], let errorString = dict["error"] as? String {
                        let error = NSError(domain: Networking.Error.ThundrCraftDomain, code: Networking.Error.Code.GeneralError.rawValue, userInfo: [NSLocalizedDescriptionKey: errorString])
                        return .Failure(error)
                    } else {
                        return .Failure(validationError)
                    }
                }
            }
            return result
        }
    }
    
    public func responseAPIJSON(completionHandler: Response<AnyObject, NSError> -> Void) -> Self {
        return response(responseSerializer: Request.APIJSONResponseSerializer(), completionHandler: completionHandler)
    }
}
