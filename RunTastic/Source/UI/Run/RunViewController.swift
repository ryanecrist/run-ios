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
    
    enum State {
        case new
        case start
        case finish
    }
    
    var state = State.new
    
    @objc
    func actionButtonPressed(_ sender: UIButton) {
        
        switch state {
        case .new:
            runManager.createRun()
            state = .start
            break
        case .start:
            runManager.startRun()
            state = .finish
            break
        case .finish:
            runManager.finishRun()
            state = .new
            break
        }

        // Update the button (disabling animations is required due to hiding the tab bar).
        UIView.performWithoutAnimation {
            switch state {
            case .new:
                sender.backgroundColor = .secondary
                sender.setTitle("NEW RUN", for: .normal)
                runView.headerView.durationLabel.text = "00:00:00.00"
                runView.headerView.distanceLabel.text = "0.00 mi"
                runView.headerView.paceLabel.text = "0:00 / mi"
                break
            case .start:
                sender.backgroundColor = .start
                sender.setTitle("START", for: .normal)
                break
            case .finish:
                sender.backgroundColor = .finish
                sender.setTitle("FINISH", for: .normal)
                break
            }
            
            sender.layoutIfNeeded()
        }
        
        // Reset header.
        runView.headerView.isCollapsed = state == .new
        runView.setHeaderViewHidden(state == .new, animated: true)
    
        // Hide the tab bar.
        if let tabBarController = tabBarController {
            tabBarController.setTabBarHidden(state != .new, animated: true)
        }
    }
}

extension RunViewController: MKMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
        // Follow user by default once map loads.
        mapView.setUserTrackingMode(.follow, animated: true)
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
    }
}

