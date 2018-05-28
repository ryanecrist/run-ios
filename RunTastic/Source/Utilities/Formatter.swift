//
//  Formatter.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/28/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

class Formatter {
    
    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy 'at' h:mm a"
        return dateFormatter
    }()
    
    /// This class should not be instantiated.
    private init() {}
    
    static func date(_ milliseconds: Int) -> String {
        
        let date = Date(millisecondsSinceEpoch: milliseconds)
        
        return dateFormatter.string(from: date)
    }
    
    static func duration(_ duration: TimeInterval) -> String {
        
        let hours = Int(duration / 3600)
        let minutes = (Int(duration) - (hours * 3600)) / 60
        let seconds = duration - TimeInterval(hours * 3600) - TimeInterval(minutes * 60)
        
        return String(format: "%02d:%02d:%05.2f", hours, minutes, seconds)
    }
    
    static func distance(_ distance: Double) -> String {

        let miles = 0.000621371192 * distance
        
        return String(format: "%.2f mi", miles)
    }
    
    static func pace(_ pace: TimeInterval) -> String {

        let paceMinutes = Int(pace) / 60
        let paceSeconds = Int(pace) - (paceMinutes * 60)
        
        return String(format: "%d:%02d / mi", paceMinutes, paceSeconds)
    }
}
