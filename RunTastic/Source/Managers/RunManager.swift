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

class RunManager {
    
    // MARK: - Public Properties
    
    private(set) var currentRun: Run? = nil
    
    weak var delegate: RunManagerDelegate?
    
    // MARK: - Private Properties
    
    private let _locationManager = CLLocationManager()
    
    private var _timer: Timer?
    
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
                                        
            currentRun.duration = Date().timeIntervalSince(start)
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
