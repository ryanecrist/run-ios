//
//  RunSettings.swift
//  RunTastic
//
//  Created by Ryan Crist on 6/2/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

class RunSettings {
    
    var targetPace: TimeInterval?
    
    var targetPaceMillis: Int? {
        
        if let targetPace = targetPace {
            return Int(targetPace) * 1000
        }
        
        return nil
    }
}
