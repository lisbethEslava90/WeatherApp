//
//  Constant.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(NSError?)
    
    public var isSuccess: Bool {
        switch self{
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

enum Errors {
    enum ErrorInformation {
        struct Request {
        }
        
        struct Response {
            let error: NSError
        }
        
        struct ViewModel {
            let errorMesage: String
            let error: NSError
        }
    }
}
