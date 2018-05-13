//
//  Location.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import CoreLocation
import Foundation

struct Location: Decodable {
    
    let id: Int
    
    let latitude: Double
    
    let longitude: Double
    
    let elevation: Double?
    
    let timestampMs: Int
    
    var timestamp: Date {
        return Date(millisecondsSinceEpoch: timestampMs)
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case latitude = "latitude"
        case longitude = "longitude"
        case elevation = "elevation"
        case timestampMs = "timestamp"
    }
    
    struct Update: Encodable {
        let latitude: Double
        let longitude: Double
        let elevation: Double?
        let timestampMs: Int
        
        enum CodingKeys: String, CodingKey {
            case latitude = "latitude"
            case longitude = "longitude"
            case elevation = "elevation"
            case timestampMs = "timestamp"
        }
    }
}
