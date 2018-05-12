//
//  HTTPResponse.swift
//  RacYa
//
//  Created by Ryan Crist on 4/23/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

struct HTTPResponse<T> {
    
    let result: HTTPResult<T>
    
    let urlResponse: HTTPURLResponse?
    
    var value: T? {
        return result.value
    }
    
    var error: Error? {
        return result.error
    }
    
    init(result: HTTPResult<T>,
         urlResponse: HTTPURLResponse? = nil) {
        self.result = result
        self.urlResponse = urlResponse
    }
}
