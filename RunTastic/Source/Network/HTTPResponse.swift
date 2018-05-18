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
    
    var data: Data?
    
    var value: T? {
        return result.value
    }
    
    var error: Error? {
        return result.error
    }
    
    init(data: Data? = nil,
         result: HTTPResult<T>,
         urlResponse: HTTPURLResponse? = nil) {
        self.data = data
        self.result = result
        self.urlResponse = urlResponse
    }
}
