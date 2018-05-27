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
    
    private var _runId: Int? = 0
    
    private var _timer: Timer?
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        // Setup location manager.
        _locationManager.delegate = self
    }
    
    // MARK: - Public Methods
    
    func reset() {
        currentRun = nil
    }
    
    @discardableResult
    func createRun() -> Run {
        
        // Make API call to create run.
//        RunTasticAPI.createRun()
//            .start() { (response: HTTPResponse<CreateRunDTO>) in
//                print("RUN CREATED!: \(response.result)")
//                self._runId = response.value?.id
//            }
        
        // Create local run.
        let run = Run()
        currentRun = run
        return run
    }
    
    func startRun() {
        
        // Abort if a run hasn't been created.
        guard let currentRun = currentRun,
              let runId = _runId
        else { return }
        
        // Set run start time and state.
        let start = Date()
        currentRun.start = start
        currentRun.state = .started
        
        // Make API call to start run.
//        RunTasticAPI.startRun(with: runId,
//                              startTime: start.millisecondsSinceEpoch)
//            .start() { (response: HTTPEmptyResponse) in
//                print("RUN STARTED!: \(response.result)")
//            }
        
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
        
        guard let currentRun = currentRun,
              let runId = _runId
        else { return }
        
        // Set run finish time and state.
        let finish = Date()
        currentRun.finish = finish
        currentRun.state = .finished
        
        // Make API call to start run.
//        RunTasticAPI.finishRun(with: runId,
//                               finishTime: finish.millisecondsSinceEpoch,
//                               locations: currentRun.route.map({ Location($0) }))
//            .start() { (response: HTTPEmptyResponse) in
//                print("RUN STARTED!: \(response.result)")
//            }
        
        // Stop the timer.
        _timer?.invalidate()
    }
    
    // MARK: - Private Methods
    
    func sumLocations(_ locations: [CLLocation]) -> CLLocationDistance {
        
        guard locations.count > 1 else { return 0 }
        
        var distance: CLLocationDistance = 0
        
        for i in 1 ..< locations.count {
            distance += locations[i].distance(from: locations[i - 1])
        }
        
        return distance
    }
}

extension RunManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Abort if no run is in progress.
        guard let currentRun = currentRun else { return }
        
        // Get the distance of the locations.
        var distance = sumLocations(locations)
        
        // If there was a previous location.
        if let lastLocation = currentRun.route.last {
            
            // TODO
            // This method is guaranteed to have at least one object
            distance += locations.first!.distance(from: lastLocation)
        }
        
        // Update run metrics.
        currentRun.pace = locations.last!.speed
        currentRun.distance += distance
        currentRun.route += locations
    }
}
