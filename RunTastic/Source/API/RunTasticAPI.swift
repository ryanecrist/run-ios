//
//  RunTasticAPI.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

class RunTasticAPI {
    
    static let client = HTTPClient.client(named: "RunTastic")
    
    static func createRun() -> HTTPRequest {
        return HTTPClient.client().request(method: .post,
                                           path: "runs/create",
                                           headers: ["Content-Type": "application/json"],
                                           with: HTTPRequestEncoders.json,
                                           data: Run.Create.Request())
    }
}
