//
//  DateExtension.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

extension Date {
    
    static var millisecondsSinceEpoch: Double {
        return Date().timeIntervalSince1970 * 1000
    }
    
    init(millisecondsSinceEpoch: Int) {
        self.init(timeIntervalSince1970: TimeInterval(millisecondsSinceEpoch / 1000))
    }
}
