//
//  Run.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/20/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import CoreLocation
import Foundation

enum RunState {
    case created
    case started
    case paused
    case finished
}

class Run {
    
    var start: Date?
    
    var finish: Date?
    
    var state = RunState.created
    
    var duration: TimeInterval = 0
    
    var distance: Double = 0
    
    var pace: Double = 0
    
    var route: [CLLocation] = []
}
