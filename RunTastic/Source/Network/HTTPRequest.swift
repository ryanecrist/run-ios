//
//  HTTPRequest.swift
//  RacYa
//
//  Created by Ryan Crist on 4/22/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

struct HTTPRequest {
    
    weak var client: HTTPClient?
    
    var urlRequest: URLRequest?
    
    init(url: URL?) {
        urlRequest = URLRequest(url: url)
    }
    
    func start<T>(with responseDecoder: @escaping HTTPResponseDecoder<T>,
                  completionHandler: ((HTTPResponse<T>) -> Void)? = nil) {
        client?.start(self, with: responseDecoder, completionHandler: completionHandler)
    }
}

extension URLRequest {
    
    init?(url: URL?) {
        guard let url = url else { return nil }
        self.init(url: url)
    }
}


