//
//  RunManager.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/20/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import CoreLocation
import Foundation

protocol RunManagerDelegate: class {
    func runManager(_ runManager: RunManager, didUpdateMetricsForRun run: Run)
}

class RunManager: NSObject {
    
    // MARK: - Public Properties
    
    private(set) var currentRun: Run? = nil
    
    weak var delegate: RunManagerDelegate?
    
    // MARK: - Private Properties
    
    private let _locationManager = CLLocationManager()
    
    private var _timer: Timer?
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        // Setup location manager.
        _locationManager.delegate = self
    }
    
    // MARK: - Public Methods
    
    @discardableResult
    func createRun() -> Run {
        let run = Run()
        currentRun = run
        return run
    }
    
    func startRun() {
        
        guard let currentRun = currentRun else { return }
        
        // Set run start time and state.
        currentRun.start = Date()
        currentRun.state = .started
        
        // Start the location manager.
        _locationManager.startUpdatingLocation()
        
        // Setup the timer.
        _timer = Timer.scheduledTimer(withTimeInterval: 0.01,
                                     repeats: true) { (_) in

            // TODO need to prevent start date mutation after being set
            guard let start = currentRun.start else { return }
                                        
            // Update the run duration.
            currentRun.duration = Date().timeIntervalSince(start)
                                        
            // Notify the delegate of the changes.
            self.delegate?.runManager(self, didUpdateMetricsForRun: currentRun)
        }
    }
    
    func finishRun() {
        
        guard let currentRun = currentRun else { return }
        
        // Set run finish time and state.
        currentRun.finish = Date()
        currentRun.state = .finished
        
        // Stop the timer.
        _timer?.invalidate()
    }
}

extension RunManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Abort if no run is in progress.
        guard let currentRun = currentRun else { return }
        
        var distance: CLLocationDistance = 0
        
        if locations.count > 1 {
            for i in 1 ..< locations.count {
                distance += locations[i].distance(from: locations[i - 1])
            }
        }
        
        // If there was a previous location.
        if let lastLocation = currentRun.route.last {
            
            // TODO
            // This method is guaranteed to have at least one object
            distance += locations.first!.distance(from: lastLocation)
        }
        
        // Update the run distance and route.
        currentRun.distance += distance
        currentRun.route += locations
    }
}
