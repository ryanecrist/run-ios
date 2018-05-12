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
        let configuration = HTTPClientConfiguration(baseEndpoint: "https://buchta-raceapi.herokuapp.com")
        return HTTPClient.configure(name: "RunTastic", with: configuration)
    }()
    
    static func createRun() -> HTTPRequest {
        return client.request(method: .post,
                              path: "runs/create",
                              headers: ["Content-Type": "application/json"],
                              with: HTTPRequestEncoders.json,
                              data: Run.Create.Request())
    }
    
    static func getRuns() -> HTTPRequest {
        return client.request(path: "runs")
    }
    
    static func getRun(with id: Int) -> HTTPRequest {
        return client.request(path: "runs/\(id)")
    }
}
