//
//  HTTPClientConfiguration.swift
//  RacYa
//
//  Created by Ryan Crist on 4/22/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

class HTTPClientConfiguration {
    
    let baseEndpoint: String?
    
    init(baseEndpoint: String? = nil) {
        self.baseEndpoint = baseEndpoint
    }
}
