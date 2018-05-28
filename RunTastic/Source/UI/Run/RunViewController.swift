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
    
    let mapManager = MapManager()
    
    let runManager = RunManager()
    
    lazy var runView = RunView()
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Setup title and tab bar item.
        title = "Run"
        tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "Run"), selectedImage: #imageLiteral(resourceName: "Run"))
    }

    override func loadView() {
        view = runView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup map manager.
        mapManager.mapView = runView.mapView
        
        // Setup run manager.
        runManager.delegate = self
        
        // Setup run view.
        runView.actionButton.setTitle("NEW RUN", for: .normal)
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
                mapManager.addRouteToMap(currentRun.route)
                
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
}

extension RunViewController: RunManagerDelegate {
    
    func runManager(_ runManager: RunManager, didUpdateMetricsForRun run: Run) {

        // Update header.
        runView.headerView.durationLabel.text = Formatter.duration(run.duration)
        runView.headerView.distanceLabel.text = Formatter.distance(run.distance)
        runView.headerView.paceLabel.text = Formatter.pace(run.pace)
    }
}

