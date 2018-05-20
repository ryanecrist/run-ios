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
    
    @objc
    func actionButtonPressed(_ sender: UIButton) {

        // Update the button (disabling animations is required due to hiding the tab bar).
        UIView.performWithoutAnimation {
            sender.backgroundColor = .start
            sender.setTitle("START", for: .normal)
            sender.layoutIfNeeded()
        }
        
        runView.headerView.durationLabel.text = "--:--.--"
        runView.headerView.distanceLabel.text = "0.00 mi"
        runView.headerView.paceLabel.text = "0:00 / mi"
        
        // Reset header.
        runView.headerView.isCollapsed = !runView.headerView.isCollapsed
        runView.setHeaderViewHidden(!runView.isHeaderViewHidden, animated: true)
        
        // Hide the navigation bar.
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(!navigationController.isNavigationBarHidden, animated: true)
        }
    
        // Hide the tab bar.
        if let tabBarController = tabBarController {
            tabBarController.setTabBarHidden(!tabBarController.isTabBarHidden, animated: true)
        }
    }
}

extension RunViewController: MKMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
        // Follow user by default once map loads.
        mapView.setUserTrackingMode(.follow, animated: true)
    }
}

