//
//  RunViewController.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/19/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import MapKit
import UIKit

class RunViewController: UIViewController {
    
    let runManager = RunManager()
    
    lazy var runView = RunView()
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Setup title and tab bar item.
        title = "Run"
        tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "Map"), selectedImage: #imageLiteral(resourceName: "Map"))
    }

    override func loadView() {
        view = runView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup run manager.
        runManager.delegate = self
        
        // Setup run view.
        runView.actionButton.setTitle("NEW RUN", for: .normal)
        runView.mapView.delegate = self
        runView.mapView.showsUserLocation = true
        
        // Add action listener.
        runView.actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Track user by default.
        runView.mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    @objc
    func actionButtonPressed(_ sender: UIButton) {
        
        // Check if there is an existing run.
        if let currentRun = runManager.currentRun {
            
            switch currentRun.state {
            case .created:
                
                // Start run.
                runManager.startRun()
                
                // Update action button.
                sender.backgroundColor = .finish
                sender.setTitle("FINISH", for: .normal)
                
            case .started:
                
                // Finish run.
                runManager.finishRun()
                
                // Hide user (for now).
                runView.mapView.showsUserLocation = false
                runView.mapView.userTrackingMode = .none
                
                // Show finished run on map.
                updateMapWithFinishedRun()
                
                // Update action button.
                sender.backgroundColor = .secondary
                sender.setTitle("DONE", for: .normal)
               
            case .finished:
                
                // Reset the run manager.
                runManager.reset()
                
                // Clear the map.
                runView.mapView.removeOverlays(runView.mapView.overlays)
                runView.mapView.removeAnnotations(runView.mapView.annotations)
                
                // Show/track the user (again).
                runView.mapView.showsUserLocation = true
                runView.mapView.setUserTrackingMode(.follow, animated: true)
                
                // Update action button.
                sender.backgroundColor = .secondary
                sender.setTitle("NEW RUN", for: .normal)
                
                // Hide header.
                runView.headerView.isCollapsed = true
                runView.setHeaderViewHidden(true, animated: true)
                
                // Hide the tab bar.
                tabBarController?.setTabBarHidden(false, animated: true)
            }
            
        } else {
            
            // Create a new run.
            runManager.createRun()
            
            // Update action button.
            sender.backgroundColor = .start
            sender.setTitle("START", for: .normal)
            
            // Reset and show header.
            runView.headerView.durationLabel.text = "00:00:00.00"
            runView.headerView.distanceLabel.text = "0.00 mi"
            runView.headerView.paceLabel.text = "0:00 / mi"
            runView.headerView.isCollapsed = false
            runView.setHeaderViewHidden(false, animated: true)
            
            // Hide the tab bar.
            tabBarController?.setTabBarHidden(true, animated: true)
        }
    }
    
    private func updateMapWithFinishedRun() {
        
        // Abort if there are less than 2 locations in the route.
        guard let locations = runManager.currentRun?.route, locations.count >= 2 else { return }
        
        // Get coordinates and create route line.
        let coordinates = locations.map({ $0.coordinate })
        let routeLine = MKPolyline(coordinates: coordinates, count: coordinates.count)
        
        // Set the visible region of the map to contain the route.
        runView.mapView.setVisibleMapRect(routeLine.boundingMapRect,
                                          edgePadding: UIEdgeInsets(top: 25,
                                                                    left: 25,
                                                                    bottom: 25,
                                                                    right: 25),
                                          animated: false)
        runView.mapView.add(routeLine)
        
        // Add the start point.
        if let startCoordinate = coordinates.first {
            let startAnnotation = MKPointAnnotation()
            startAnnotation.coordinate = startCoordinate
            startAnnotation.title = "Start"
            runView.mapView.addAnnotation(startAnnotation)
        }
        
        // Add the finish point.
        if let finishCoordinate = coordinates.last {
            let finishAnnotation = MKPointAnnotation()
            finishAnnotation.coordinate = finishCoordinate
            finishAnnotation.title = "Finish"
            runView.mapView.addAnnotation(finishAnnotation)
        }
    }
}

extension RunViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        // TODO
        // Handle multiple overlays.
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5
        renderer.strokeColor = UIColor.black.withAlphaComponent(0.5)
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // TODO find more appropriate way to prevent overriding the user annotation.
        guard !(annotation is MKUserLocation) else { return nil }
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKMarkerAnnotationView
        
        if view == nil {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            
            if annotation.title == "Start" {
                view?.markerTintColor = .start
            } else if annotation.title == "Finish" {
                view?.markerTintColor = .finish
            }
        }
        
        return view
    }
}

extension RunViewController: RunManagerDelegate {
    
    func runManager(_ runManager: RunManager, didUpdateMetricsForRun run: Run) {
        
        let hours = Int(run.duration) / 3600
        let minutes = (Int(run.duration) - (hours * 3600)) / 60
        let seconds = run.duration - TimeInterval(hours * 3600) - TimeInterval(minutes * 60)
        
        runView.headerView.durationLabel.text =
            String(format: "%02d:%02d:%05.2f", hours, minutes, seconds)
        
        let miles = 0.000621371192 * run.distance
        
        runView.headerView.distanceLabel.text = String(format: "%.2f mi", miles)
        
        let secondsPerMile = run.pace > 0 ? (1 / run.pace) * (1 / 0.000621371192) : 0
        let paceMinutes = Int(secondsPerMile) / 60
        let paceSeconds = Int(secondsPerMile) - (paceMinutes * 60)
        
        runView.headerView.paceLabel.text = String(format: "%d:%02d / mi", paceMinutes, paceSeconds)
    }
}

