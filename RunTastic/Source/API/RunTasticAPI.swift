//
//  RunTasticAPI.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

class RunTasticAPI {
    
    static let client: HTTPClient = {
        // Setup HTTP client.
        let configuration = HTTPClientConfiguration(baseEndpoint: Configuration.baseEndpoint)
        return HTTPClient.configure(name: "RunTastic", with: configuration)
    }()
    
    static func createRun() -> HTTPRequest {
        return client.request(method: .post,
                              path: "runs/create",
                              headers: ["Authorization": "Bearer token",
                                        "ID": "Email someone@example.com"])
    }
    
    static func getRuns() -> HTTPRequest {
        return client.request(path: "runs",
                              headers: ["Authorization": "Bearer token",
                                        "ID": "Email someone@example.com"])
    }
    
    static func getRun(with id: Int) -> HTTPRequest {
        return client.request(path: "runs/\(id)",
                              headers: ["Authorization": "Bearer token",
                                        "ID": "Email someone@example.com"])
    }
    
    static func startRun(with id: Int, startTime: Int) -> HTTPRequest {
        return client.request(method: .post,
                              path: "runs/\(id)/start",
                              headers: ["Authorization": "Bearer token",
                                        "Content-Type": "application/json",
                                        "ID": "Email someone@example.com"],
                              with: HTTPRequestEncoders.json,
                              data: Run2.Start.Request(timestamp: startTime))
    }
    
    static func finishRun(with id: Int, endTime: Int) -> HTTPRequest {
        return client.request(method: .post,
                              path: "runs/\(id)/finish",
                              headers: ["Authorization": "Bearer token",
                                        "Content-Type": "application/json",
                                        "ID": "Email someone@example.com"],
                              with: HTTPRequestEncoders.json,
                              data: Run2.Finish.Request(timestamp: endTime))
    }
    
    static func getRunRoute(with id: Int) -> HTTPRequest {
        return client.request(path: "runs/\(id)/route",
                              headers: ["Authorization": "Bearer token",
                                        "ID": "Email someone@example.com"])
    }
    
    static func addRunLocations(with id: Int, locations: [Location.Update]) -> HTTPRequest {
        return client.request(method: .post,
                              path: "runs/\(id)/geoPoints",
                              headers: ["Authorization": "Bearer token",
                                        "Content-Type": "application/json",
                                        "ID": "Email someone@example.com"],
                              with: HTTPRequestEncoders.json,
                              data: locations)
    }
}
