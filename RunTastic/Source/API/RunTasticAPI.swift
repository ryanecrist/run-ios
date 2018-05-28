//
//  RunTasticAPI.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import CoreLocation
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
                              data: StartRunDTO(timestamp: startTime))
    }
    
    static func finishRun(with id: Int, finishTime: Int, locations: [CLLocation]?) -> HTTPRequest {
        return client.request(method: .post,
                              path: "runs/\(id)/finish",
                              headers: ["Authorization": "Bearer token",
                                        "Content-Type": "application/json",
                                        "ID": "Email someone@example.com"],
                              with: HTTPRequestEncoders.json,
                              data: FinishRunDTO(timestamp: finishTime,
                                                 locations: locations?.map({ LocationDTO($0) })))
    }
    
    static func getRunRoute(with id: Int) -> HTTPRequest {
        return client.request(path: "runs/\(id)/route",
                              headers: ["Authorization": "Bearer token",
                                        "ID": "Email someone@example.com"])
    }
    
    static func updateRun(with id: Int, locations: [CLLocation]) -> HTTPRequest {
        return client.request(method: .post,
                              path: "runs/\(id)/geoPoints",
                              headers: ["Authorization": "Bearer token",
                                        "Content-Type": "application/json",
                                        "ID": "Email someone@example.com"],
                              with: HTTPRequestEncoders.json,
                              data: locations.map({ LocationDTO($0) }))
    }
}

struct CreateRunDTO: Codable {
    let id: Int
}

struct StartRunDTO: Codable {
    let timestamp: Int
}

struct FinishRunDTO: Codable {
    let timestamp: Int
    let locations: [LocationDTO]?
}

struct RunDTO: Codable {
    let id: Int
    let startTime: Int?
    let endTime: Int?
    let distance: Double?
}

struct LocationDTO: Codable {
    
    let latitude: Double
    let longitude: Double
    let elevation: Double?
    let timestamp: Int
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(_ location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.elevation = location.altitude
        self.timestamp = location.timestamp.millisecondsSinceEpoch
    }
}

