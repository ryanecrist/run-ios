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
                              path: "runs/create")
    }
    
    static func getRuns() -> HTTPRequest {
        return client.request(path: "runs")
    }
    
    static func getRun(with id: Int) -> HTTPRequest {
        return client.request(path: "runs/\(id)")
    }
    
    static func startRun(with id: Int, startTime: Int) -> HTTPRequest {
        return client.request(method: .post,
                              path: "runs/\(id)/start",
                              headers: ["Content-Type": "application/json"],
                              with: HTTPRequestEncoders.json,
                              data: Run.Start.Request(timestamp: startTime))
    }
    
    static func finishRun(with id: Int, endTime: Int) -> HTTPRequest {
        return client.request(method: .post,
                              path: "runs/\(id)/finish",
                              headers: ["Content-Type": "application/json"],
                              with: HTTPRequestEncoders.json,
                              data: Run.Finish.Request(timestamp: endTime))
    }
    
    static func getRunRoute(with id: Int) -> HTTPRequest {
        return client.request(path: "runs/\(id)/route")
    }
    
    static func addRunLocations(with id: Int, locations: [Location.Update]) -> HTTPRequest {
        return client.request(method: .post,
                              path: "runs/\(id)/geoPoints",
                              headers: ["Content-Type": "application/json"],
                              with: HTTPRequestEncoders.json,
                              data: locations)
    }
}
