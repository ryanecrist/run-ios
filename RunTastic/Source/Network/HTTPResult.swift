//
//  HTTPResult.swift
//  RacYa
//
//  Created by Ryan Crist on 4/23/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

enum HTTPResult<T> {
    case success(value: T)
    case failure(error: Error)
    
    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }
    
    var isFailure: Bool {
        return !isSuccess
    }
    
    var value: T? {
        switch self {
        case .success(let value): return value
        case .failure:            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .success:            return nil
        case .failure(let error): return error
        }
    }
}
