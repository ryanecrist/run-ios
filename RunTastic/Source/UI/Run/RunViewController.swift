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
    
    // MARK: - Public Properties
    
    let mapManager = MapManager()
    
    let runManager = RunManager()
    
    lazy var runView = RunView()
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Setup title and tab bar item.
        title = "Run"
        tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "Run"), selectedImage: #imageLiteral(resourceName: "Run"))
    }
    
    // MARK: - View Lifecycle

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
        runView.headerView.targetPaceButton.addTarget(self, action: #selector(targetPaceButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Track user by default.
        runView.mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    // MARK: - Action Handlers
    
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
                runView.headerView.setCollapsed(true, animated: true)
                
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
            runView.headerView.setCollapsed(false, animated: true)
            
            // Hide the tab bar.
            tabBarController?.setTabBarHidden(true, animated: true)
        }
    }
    
    @objc
    func targetPaceButtonPressed(_ sender: UIButton) {
        
        // Setup pace picker accessory view.
        let pacePickerAccessoryView = PacePickerAccessoryView()
        pacePickerAccessoryView.doneButton.addTarget(target: self,
                                                     action: #selector(doneButtonPressed))
        
        // Show pace picker view.
        runView.headerView.targetPaceTextView.inputView = PacePickerView()
        runView.headerView.targetPaceTextView.inputAccessoryView = pacePickerAccessoryView
        runView.headerView.targetPaceTextView.becomeFirstResponder()
    }
    
    @objc
    func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let pacePickerView =
            runView.headerView.targetPaceTextView.inputView as? PacePickerView else { return }
        
        // Update header view with target pace.
        runView.headerView.targetPaceTextView.text = Formatter.pace(pacePickerView.selectedPace)
        
        // Hide pace picker view.
        runView.headerView.targetPaceTextView.resignFirstResponder()
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

