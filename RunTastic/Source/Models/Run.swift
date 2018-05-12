//
//  Run.swift
//  RacYa
//
//  Created by Ryan Crist on 4/22/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

struct Run: Decodable {
    
    let id: Int
    
    let startTime: Double?
    
    let endTime: Double?
    
    let distance: Double?
    
    struct Create {
        struct Request: Encodable {
        }
        struct Respnose: Decodable {
            let id: Int
        }
    }
    
    struct Start {
        struct Request: Encodable {
            let timestamp: Double
        }
        struct Response: Decodable {
            let id: Int
        }
    }
    
    struct Finish {
        struct Request: Encodable {
            let id: Int
            let timestamp: Double
        }
    }
}
