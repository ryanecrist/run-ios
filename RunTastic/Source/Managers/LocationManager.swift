//
//  LocationManager.swift
//  RacYa
//
//  Created by Ryan Crist on 5/9/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import CoreLocation
import Foundation

class LocationManager: CLLocationManager {
    
    // MARK: - Singleton
    
    static let shared = LocationManager()
}
