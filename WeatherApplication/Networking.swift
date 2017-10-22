//
//  Networking.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Alamofire
import Fargo

struct Networking {
    
    // MARK: - Error
    
    struct Error {
        
        static let Domain = "zw.co.zss.thundrcraft.error"
        static let ThundrCraftDomain = "zw.co.error"
        
        enum Code: Int {
            case GeneralError			= -23001
            case ParsingError			= -23002
            case DataProcessingError	= -23003
            case Unauthorized           = -23004
        }
    }
    
    // MARK: - NetworkActivityIndicator
    
    struct ActivityIndicator {
        private static var sharedIndicator = ActivityIndicator()
        private var networkIndicatorInstances = 0
        
        static func show() {
            sharedIndicator.networkIndicatorInstances += 1
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }
        
        static func hide() {
            sharedIndicator.networkIndicatorInstances -= 1
            assert(sharedIndicator.networkIndicatorInstances >= 0, "NetworkActivityIndicator called to hide more times than shown")
            UIApplication.sharedApplication().networkActivityIndicatorVisible = sharedIndicator.networkIndicatorInstances > 0
        }
    }
    
    // MARK: - Manager
    
    private static var manager = Networking.createManager(TokenModel(token: "token", type: "type", expires: NSDate()))
    
    private static func createManager(authToken: TokenModel? = nil) -> Manager {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.requestCachePolicy = .UseProtocolCachePolicy
        return Manager(configuration: configuration)
    }
    
    // MARK: - Additional
    
    static func defaultHeaders() -> [String: String] {
        var headers: [String: String] = [:]
        
        headers["Accept-Encoding"] = "gzip, deflate"
        headers["V-ApplicationVersion"] = "1.0"
        headers["V-ApplicationName"] = "weather-app"
        headers["V-ApplicationBuild"] = "1"
        return headers
    }
    
    // MARK: - Request
    
    private static func request<T>(
        method: Alamofire.Method,
        URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .JSON,
        processing: (AnyObject) -> Result<T>,
        completion: (Result<T>) -> Void)
    {
        Networking.ActivityIndicator.show()
        // Send request
        self.manager.request(method, URLString, parameters: parameters, encoding: encoding, headers: defaultHeaders())
            .validate()
            .responseAPIJSON { (response) -> Void in
                Networking.ActivityIndicator.hide()
                Networking.response(response.response, result: response.result, processing: processing, completion: completion)
        }
    }
    
    private static func request(
        method: Alamofire.Method,
        URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .JSON,
        completion: (NSError?) -> Void )
    {
        Networking.ActivityIndicator.show()
        // Send request
        self.manager.request(method, URLString, parameters: parameters, encoding: encoding, headers: defaultHeaders())
            .validate()
            .response { (_, httpResponse, data, error) -> Void in
                Networking.ActivityIndicator.hide()
                Networking.response(httpResponse, data: data, error: error, completion: completion)
        }
    }
    
    static func request<T where T: Fargo.Decodable>(
        method: Alamofire.Method,
        URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .JSON,
        completion: (Result<T>) -> Void)
    {
        
        request(method, URLString: URLString, parameters: parameters, encoding: encoding, processing: { (jsonObject) -> Result<T> in
            return Networking.processJsonObject(jsonObject)
        }, completion: completion)
    }
    
    static func request<T where T: Fargo.Decodable>(
        method: Alamofire.Method,
        URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .JSON,
        completion: (Result<[T]>) -> Void)
    {
        
        request(method, URLString: URLString, parameters: parameters, encoding: encoding, processing: { (jsonObject) -> Result<[T]> in
            return Networking.processJsonObject(jsonObject)
        }, completion: completion)
    }
    
    // MARK: - Response
    
    private static func response<T>(
        response: NSHTTPURLResponse?,
        result: Alamofire.Result<AnyObject, NSError>,
        processing: (AnyObject) -> Result<T>,
        completion: (Result<T>) -> Void)
    {
        // wrap finish in main thread
        let finish: (Result<T>) -> Void = { (result) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
               var date = NSDate()
                completion(result)
            })
        }
        
        // Check if Alamofire raised an error
        if let error = result.error {
          
        }
        else {
            if let jsonObject: AnyObject = result.value {
                // Process data
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                    // Execute processing block and check result
                    processing(jsonObject).success({ (data) -> Void in
                        finish(.Success(data))
                    }).failure({ (error) -> Void in
                        finish(.Failure(error))
                    })
                })
            }
            else {
                let error = NSError(domain: Error.Domain, code: Error.Code.ParsingError.rawValue, userInfo: nil)
                finish(.Failure(error))
            }
        }
    }
    
    private static func response(
        response: NSHTTPURLResponse?,
        data: NSData?,
        error: NSError?,
        completion: (NSError?) -> Void)
    {
        // wrap finish in main thread
        let finish: (NSError?) -> Void = { (result) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
               var date  = NSDate()
                completion(result)
            })
        }
        
        // Check if Alamofire raised an error
        if let error = error {
            // Process the error here
            let finalError = processErrorResponse(data, error: error)
            // pass it through
            finish(finalError)
        }
        else {
            if let data = data where data.length > 0 {
                //log?.debug("API request returned data where we didn't expec// it: \(data)")
            }
            
            // Complete with success
            finish(nil)
        }
    }
    
    // MARK: - Processing
    
    static func processJsonObject<T where T: Fargo.Decodable>(jsonObject: AnyObject, forKey key: String? = nil) -> Result<T> {
        // Try decoding JSON to result model object
        let json = JSON.convert(jsonObject)
        do {
            if let key = key {
                let object: T = try json.value(key)
                return .Success(object)
            } else {
                let object: T = try json.decode()
                return .Success(object)
            }
        } catch {
            // If that failed, check if we can decode json to the generic error response
            return Networking.processGenericErrorResponse(json, error: error)
        }
    }
    
    static func processJsonObject<T where T: Fargo.Decodable>(jsonObject: AnyObject, forKey key: String? = nil) -> Result<[T]> {
        // Try decoding JSON to result model object
        let json = JSON.convert(jsonObject)
        //print(json.description)
        do {
           	if let key = key {
                let object: [T] = try json.value(key)
                
                return .Success(object)
               } else {
                let object: [T] = try json.decode()
                
                for item in object.enumerate() {
                    
                }
                
                
                return .Success(object)
            }
        } catch {
            // If that failed, check if we can decode json to the generic error response
            return Networking.processGenericErrorResponse(json, error: error)
        }
    }
    
    // MARK: - Error & Validation
    
    static func processGenericErrorResponse<T>(json: JSON, error originalError: ErrorType) -> Result<T> {
        do {
            let codeResponse = try CodeResponse.decode(json)
            // if this succeeded, we can create a nicer error
            let e = NSError(domain: Error.ThundrCraftDomain, code: Int(codeResponse.responseCode) ?? -1, userInfo: [NSLocalizedDescriptionKey: codeResponse.description])
            //log?.info("API error: \(e)")
            return .Failure(e)
        } catch {
            // If this also failed, we bail out
            let e = NSError(domain: Error.Domain, code: Error.Code.DataProcessingError.rawValue, userInfo: [NSLocalizedDescriptionKey: "\(originalError)"])
            //log?.info("API error: \(e)")
            return .Failure(e)
        }
    }
    
    private static func processErrorResponse(data: NSData?, error: NSError) -> NSError {
        guard let data = data where data.length > 0 else {
            return error
        }
        
        // Try deserializing error
        do {
            let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            let errorResponse: ErrorResponse = try JSON.convert(jsonObject).decode()
            let finalError = NSError(domain: Error.ThundrCraftDomain, code: Int(errorResponse.errorCode) ?? -1, userInfo: [NSLocalizedDescriptionKey: errorResponse.description])
            return finalError
        } catch { }
        
        return error
    }
    
    // MARK: - No response requests
    
    static func POST(URLString: URLStringConvertible, parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = .JSON, completion: (NSError?) -> Void) {
        request(.POST, URLString: URLString, parameters: parameters, encoding: encoding, completion: completion)
    }
    
    static func PUT(URLString: URLStringConvertible, parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = .JSON, completion: (NSError?) -> Void) {
        request(.PUT, URLString: URLString, parameters: parameters, encoding: encoding, completion: completion)
    }
    
    static func DELETE(URLString: URLStringConvertible, parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = .JSON, completion: (NSError?) -> Void) {
        request(.DELETE, URLString: URLString, parameters: parameters, encoding: encoding, completion: completion)
    }
    
    // MARK: - Model requests
    
    static func GET<T where T: Fargo.Decodable>(
        URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .JSON,
        processing: ((AnyObject) -> Result<T>)? = nil,
        completion: (Result<T>) -> Void)
    {
        guard let processing = processing else {
            return request(.GET, URLString: URLString, parameters: parameters, encoding: encoding, completion: completion)
        }
        
        request(.GET, URLString: URLString, parameters: parameters, encoding: encoding, processing: processing, completion: completion)
    }
    
    static func POST<T where T: Fargo.Decodable>(
        URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .JSON,
        processing: ((AnyObject) -> Result<T>)? = nil,
        completion: (Result<T>) -> Void)
    {
        guard let processing = processing else {
            return request(.POST, URLString: URLString, parameters: parameters, encoding: encoding, completion: completion)
        }
        
        request(.POST, URLString: URLString, parameters: parameters, encoding: encoding, processing: processing, completion: completion)
    }
    
    static func PUT<T where T: Fargo.Decodable>(
        URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .JSON,
        processing: ((AnyObject) -> Result<T>)? = nil,
        completion: (Result<T>) -> Void)
    {
        guard let processing = processing else {
            return request(.PUT, URLString: URLString, parameters: parameters, encoding: encoding, completion: completion)
        }
        
        request(.PUT, URLString: URLString, parameters: parameters, encoding: encoding, processing: processing, completion: completion)
    }
    
    // MARK: - Model collections requests
    
    static func GET<T where T: Fargo.Decodable>(
        URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .JSON,
        processing: ((AnyObject) -> Result<[T]>)? = nil,
        completion: (Result<[T]>) -> Void)
    {
        guard let processing = processing else {
            return request(.GET, URLString: URLString, parameters: parameters, encoding: encoding, completion: completion)
        }
        
        request(.GET, URLString: URLString, parameters: parameters, encoding: encoding, processing: processing, completion: completion)
    }
    
    static func POST<T where T: Fargo.Decodable>(
        URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .JSON,
        processing: ((AnyObject) -> Result<[T]>)? = nil,
        completion: (Result<[T]>) -> Void)
    {
        guard let processing = processing else {
            return request(.POST, URLString: URLString, parameters: parameters, encoding: encoding, completion: completion)
        }
        
        request(.POST, URLString: URLString, parameters: parameters, encoding: encoding, processing: processing, completion: completion)
    }
    
    static func PUT<T where T: Fargo.Decodable>(
        URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .JSON,
        processing: ((AnyObject) -> Result<[T]>)? = nil,
        completion: (Result<[T]>) -> Void)
    {
        guard let processing = processing else {
            return request(.PUT, URLString: URLString, parameters: parameters, encoding: encoding, completion: completion)
        }
        
        request(.PUT, URLString: URLString, parameters: parameters, encoding: encoding, processing: processing, completion: completion)
    }
}
