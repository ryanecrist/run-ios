//
//  HTTPClient.swift
//  RacYa
//
//  Created by Ryan Crist on 4/22/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get
    case head
    case post
    case put
    case delete
    case connect
    case options
    case trace
    case patch
}

enum HTTPClientError: Error {
    case invalidRequest
    case invalidResponse
    case clientError
    case serverError
}

class HTTPClient {
    
    // MARK: - Private Static Properties
    
    private static let defaultName = "default"
    
    private static var clients: [String:HTTPClient] = [:]
    
    // MARK: - Public Static Methods
    
    @discardableResult
    static func configure(with configuration: HTTPClientConfiguration = HTTPClientConfiguration()) -> HTTPClient {
        return configure(name: defaultName, with: configuration)
    }
    
    @discardableResult
    static func configure(name: String, with configuration: HTTPClientConfiguration = HTTPClientConfiguration()) -> HTTPClient {
        
        if let client = clients[name] {
            return client
        }
        
        let client = HTTPClient(name: name, configuration: configuration)
        clients[name] = client
        return client
    }
    
    static func client() -> HTTPClient {
        return client(named: defaultName)
    }
    
    static func client(named name: String) -> HTTPClient {
        
        guard let client = clients[name] else {
            NSLog("Client with name \"\(name)\" not configured!")
            return configure(name: name, with: HTTPClientConfiguration())
        }
        
        return client
    }
    
    // MARK: - Public Properties
    
    let name: String
    
    let configuration: HTTPClientConfiguration
    
    let session: URLSession
    
    // MARK: - Initializers
    
    init(name: String,
         configuration: HTTPClientConfiguration) {
        self.name = name
        self.configuration = configuration
        self.session = URLSession.shared
    }
    
    // MARK: - Public Methods
    
    func delete() {
        HTTPClient.clients[name] = nil
    }
    
    func request(method: HTTPMethod = .get,
                 path: String,
                 headers: [String:Any] = [:],
                 data: Data? = nil) -> HTTPRequest {
        
        var prefix = ""
        
        if let baseEndpoint = configuration.baseEndpoint {
            prefix = baseEndpoint + "/"
        }
        
        var request = HTTPRequest(url: URL(string: prefix + path))
        request.client = self
        request.urlRequest?.httpBody = data
        request.urlRequest?.httpMethod = method.rawValue
        
        // Add headers.
        for (key, value) in headers {
            request.urlRequest?.setValue("\(value)", forHTTPHeaderField: key)
        }
        
        return request
    }
    
    func request<T>(method: HTTPMethod = .get,
                    path: String,
                    headers: [String:Any] = [:],
                    with requestEncoder: HTTPRequestEncoder<T>,
                    data: T) -> HTTPRequest {
        var httpRequest = request(method: method, path: path, headers: headers)
        requestEncoder(data, &httpRequest.urlRequest)
        return httpRequest
    }
    
    func start<T>(_ request: HTTPRequest,
                  with responseDecoder: @escaping HTTPResponseDecoder<T>,
                  completionHandler: ((HTTPResponse<T>) -> Void)? = nil) {
        
        guard let urlRequest = request.urlRequest else {
            DispatchQueue.main.async {
                completionHandler?(HTTPResponse<T>(result: HTTPResult.failure(error: HTTPClientError.invalidRequest)))
            }
            return
        }
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler?(HTTPResponse<T>(result: HTTPResult.failure(error: error)))
                }
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completionHandler?(HTTPResponse<T>(result: HTTPResult.failure(error: HTTPClientError.invalidResponse)))
                }
                return
            }
            
            print("DATA: \(data)")
            print("RESPONSE: \(response)")
            print("ERROR: \(error)")
            
            if let data = data,
                let value = try? responseDecoder(data) {
                
                DispatchQueue.main.async {
                    completionHandler?(HTTPResponse<T>(result: HTTPResult.success(value: value), urlResponse: urlResponse))
                }
                
            } else {
                // TODO handle empty response!
            }
        }
        
        dataTask.resume()
    }
}
