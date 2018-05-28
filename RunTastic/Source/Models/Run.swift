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
    case finished
}

class Run {
    
    var start: Date?
    
    var finish: Date?
    
    var state = RunState.created
    
    var duration: TimeInterval = 0
    
    var distance: Double = 0
    
    var pace: TimeInterval = 0
    
    var targetPace = UserDefaults.standard.targetPace
    
    var route: [CLLocation] = []
}
