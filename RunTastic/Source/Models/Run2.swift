//
//  Run.swift
//  RacYa
//
//  Created by Ryan Crist on 4/22/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

struct Run2: Decodable {
    
    let id: Int
    
    let startTimeMs: Int?
    
    var startTime: Date? {
        guard let startTimeMs = startTimeMs else { return nil }
        return Date(millisecondsSinceEpoch: startTimeMs)
    }
    
    let endTimeMs: Int?
    
    var endTime: Date? {
        guard let endTimeMs = endTimeMs else { return nil }
        return Date(millisecondsSinceEpoch: endTimeMs)
    }
    
    let distance: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case startTimeMs = "startTime"
        case endTimeMs = "endTime"
        case distance = "distance"
    }
    
    struct Create {
        struct Request: Encodable {
        }
        struct Respnose: Decodable {
            let id: Int
        }
    }
    
    struct Start {
        struct Request: Encodable {
            let timestamp: Int
        }
    }
    
    struct Finish {
        struct Request: Encodable {
            let timestamp: Int
        }
    }
}
