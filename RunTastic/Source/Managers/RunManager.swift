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
    
    /// The current run, if it exists.
    private(set) var currentRun: Run? = nil
    
    /// The run manager delegate.
    weak var delegate: RunManagerDelegate?
    
    // MARK: - Private Properties
    
    /// The location manager used to receive phone location updates.
    private let _locationManager = CLLocationManager()
    
    /// The last time the route was updated on the backend for the current run.
    private var _previousRouteUpdateTime = Date()
    
    /// The current batch of location updates to be sent to the backend for the current run.
    private var _routeLocationUpdate = [CLLocation]()
    
    /// The ID of the current run.
    private var _runId: String?
    
    /// TODO is this necessary?
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
        _runId = nil
    }
    
    @discardableResult
    func createRun() -> Run {
        
        // Make API call to create run.
        RunTasticAPI.createRun()
            .start() { (response: HTTPResponse<CreateRunDTO>) in
                print("RUN CREATED!: \(response.result)")
                self._runId = response.value?.id
            }
        
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
        RunTasticAPI.startRun(with: runId,
                              startTime: start.millisecondsSinceEpoch)
            .start() { (response: HTTPEmptyResponse) in
                print("RUN STARTED!: \(response.result)")
            }
        
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
        RunTasticAPI.finishRun(with: runId,
                               finishTime: finish.millisecondsSinceEpoch,
                               locations: _routeLocationUpdate)
            .start() { (response: HTTPEmptyResponse) in
                print("RUN STARTED!: \(response.result)")
            }
        
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
    
    func updateRemoteRun(with locations: [CLLocation]) {
        
        // Abort if there is no run in progress.
        guard let runId = _runId,
              currentRun?.state == .started
        else { return }
        
        // Append new locations.
        _routeLocationUpdate += locations
        
        let currentTime = Date()
        
        // Only update the route on the backend periodically.
        if currentTime.timeIntervalSince(_previousRouteUpdateTime) >= 10 {
            RunTasticAPI.updateRun(with: runId, locations: _routeLocationUpdate)
                .start() { (response: HTTPEmptyResponse) in
                    print("RUN UPDATED!: \(response.result)")
                }
            _routeLocationUpdate.removeAll()
            _previousRouteUpdateTime = currentTime
        }
    }
}

extension RunManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Abort if no run is in progress.
        guard let currentRun = currentRun,
              let currentRunStartTime = currentRun.start
        else { return }
        
        // Filter out locations that occurred before the run was officially started.
        let filteredLocations = locations.filter({ $0.timestamp > currentRunStartTime })
        
        // Abort if there isn't at least one location left.
        guard let firstLocation = filteredLocations.first,
              let lastLocation = filteredLocations.last
        else { return }
        
        // Get the distance of the locations.
        var distance = sumLocations(filteredLocations)
        
        // Add the distance to the previous location, if necessary.
        if let previousLocation = currentRun.route.last {
            distance += firstLocation.distance(from: previousLocation)
        }
        
        // Update run metrics.
        currentRun.pace = lastLocation.speed
        currentRun.distance += distance
        currentRun.route += locations
        
        // Update the remote run.
        updateRemoteRun(with: filteredLocations)
    }
}
