//
//  MapViewController.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/19/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController {
    
    lazy var mapView = MapView()
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Setup title and tab bar item.
        title = "Map"
        tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "Map"), selectedImage: #imageLiteral(resourceName: "Map"))
    }

    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup map.
        mapView.actionButton.setTitle("NEW RUN", for: .normal)
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        // Add action listener.
        mapView.actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    }
    
    @objc
    func actionButtonPressed(_ sender: UIButton) {
        print("ACTION!")
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
        // Follow user by default once map loads.
        mapView.setUserTrackingMode(.follow, animated: true)
    }
}

