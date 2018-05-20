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
        
        // Setup run view.
        runView.headerView.durationLabel.text = "31:24.45"//"--:--.--"
        runView.headerView.distanceLabel.text = "4.26 mi"//"0.00 mi"
        runView.headerView.paceLabel.text = "7:01 / mi"//"0:00 / mi"
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
            state = .start
            break
        case .start:
            state = .finish
            break
        case .finish:
            state = .new
            break
        }

        // Update the button (disabling animations is required due to hiding the tab bar).
        UIView.performWithoutAnimation {
            switch state {
            case .new:
                sender.backgroundColor = .secondary
                sender.setTitle("NEW", for: .normal)
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
        
        runView.headerView.durationLabel.text = "--:--.--"
        runView.headerView.distanceLabel.text = "0.00 mi"
        runView.headerView.paceLabel.text = "0:00 / mi"
        
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

