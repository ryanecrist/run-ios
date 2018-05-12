//
//  HTTPRequestEncoders.swift
//  RacYa
//
//  Created by Ryan Crist on 4/26/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

typealias HTTPRequestEncoder<T> = (_ data: T, _ request: inout URLRequest?) -> Void

struct HTTPRequestEncoders {
    
    static let jsonEncoder = JSONEncoder()
    
    private init() {}
    
    static func string(_ string: String, request: inout URLRequest?) {
        request?.httpBody = string.data(using: .utf8)
    }
    
    static func json<T: Encodable>(_ value: T, request: inout URLRequest?) {
        request?.httpBody = try? jsonEncoder.encode(value)
    }
}
