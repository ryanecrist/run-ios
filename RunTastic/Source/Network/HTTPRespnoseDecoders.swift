//
//  HTTPRespnoseDecoders.swift
//  RacYa
//
//  Created by Ryan Crist on 4/26/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

typealias HTTPResponseDecoder<T> = (_ data: Data) throws -> T

typealias HTTPEmptyResponse = HTTPResponse<Data?>

struct HTTPResponseDecoders {
    
    static var jsonDecoder = JSONDecoder()
    
    private init() {}
    
    static func empty(_ data: Data) throws -> Void {
        return ()
    }
    
    static func data(_ data: Data) throws -> Data {
        return data
    }
    
    static func string(_ data: Data) throws -> String {
        
        if let string = String(data: data, encoding: .utf8) {
            return string
        }
        
        throw HTTPClientError.invalidResponse
    }
    
    static func json<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

extension HTTPRequest {
    
    func start(completionHandler: ((HTTPResponse<Data>) -> Void)? = nil) {
        client?.start(self, with: HTTPResponseDecoders.data, completionHandler: completionHandler)
    }
    
    func start(completionHandler: ((HTTPResponse<Data?>) -> Void)? = nil) {
        client?.start(self, with: HTTPResponseDecoders.data, completionHandler: completionHandler)
    }
    
    func start(completionHandler: ((HTTPResponse<String>) -> Void)? = nil) {
        client?.start(self, with: HTTPResponseDecoders.string, completionHandler: completionHandler)
    }
    
    func start(completionHandler: ((HTTPResponse<String?>) -> Void)? = nil) {
        client?.start(self, with: HTTPResponseDecoders.string, completionHandler: completionHandler)
    }
    
    func start<T: Decodable>(completionHandler: ((HTTPResponse<T>) -> Void)? = nil) {
        client?.start(self, with: HTTPResponseDecoders.json, completionHandler: completionHandler)
    }
}
