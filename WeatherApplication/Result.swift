//
//  Result.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation

public enum Result<T> {
    
    case Success(T)
    case Failure(NSError)
    
    /// Calls the closure with the associated value if the result is a success. Returns self, useful for chaining
    public func success(closure: (T) -> Void) -> Result<T> {
        switch self {
        case .Success(let s):
            closure(s)
            return self
        default:
            return self
        }
    }
    
    /// Calls the closure with the associated error if the result is a failure. Returns self, useful for chaining
    public func failure(closure: (NSError) -> Void) -> Result<T> {
        switch self {
        case .Failure(let error):
            closure(error)
            return self
        default:
            return self
        }
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: T? {
        switch self {
        case .Success(let s):
            return s
        case .Failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: NSError? {
        switch self {
        case .Success:
            return nil
        case .Failure(let error):
            return error
        }
    }
}

extension Result: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Success(let s):
            return "Result<\(T.self)>(success: `\(s)`)"
        case .Failure(let error):
            return "Result<\(T.self)>(failure: `\(error)`)"
        }
    }
}

