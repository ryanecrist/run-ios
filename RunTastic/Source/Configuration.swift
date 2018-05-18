//
//  Configuration.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/17/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

enum Key: String {
    case baseEndpoint
}

struct Configuration {
    static let baseEndpoint = Bundle.main.infoDictionary![Key.baseEndpoint.rawValue] as! String
}
