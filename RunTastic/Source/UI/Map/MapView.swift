//
//  MapView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/19/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import MapKit
import UIKit

class MapView: MKMapView {
    
    let actionButton = UIButton()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Disable default compass
        showsCompass = false
        
        // Setup compass button.
        let compassButton = MKCompassButton(mapView: self)
        compassButton.compassVisibility = .adaptive
        compassButton.layer.shadowColor = UIColor.black.cgColor
        compassButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        compassButton.layer.shadowOpacity = 0.2
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup user tracking button.
        let userTrackingButton = MKUserTrackingButton(mapView: self)
        userTrackingButton.layer.shadowColor = UIColor.black.cgColor
        userTrackingButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        userTrackingButton.layer.shadowOpacity = 0.2
        userTrackingButton.layer.shadowRadius = 2.5
        userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup action button.
        actionButton.backgroundColor = .secondary
        actionButton.layer.cornerRadius = 10
        actionButton.layer.shadowColor = UIColor.black.cgColor
        actionButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        actionButton.layer.shadowOpacity = 0.2
        actionButton.layer.shadowRadius = 2.5
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews.
        addSubview(userTrackingButton)
        addSubview(compassButton)
        addSubview(actionButton)
        
        // Constrain user tracking button.
        userTrackingButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        userTrackingButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        
        // Constrain compass button.
        compassButton.topAnchor.constraint(equalTo: userTrackingButton.bottomAnchor, constant: 8).isActive = true
        compassButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        compassButton.widthAnchor.constraint(equalTo: userTrackingButton.widthAnchor).isActive = true
        compassButton.heightAnchor.constraint(equalTo: compassButton.widthAnchor).isActive = true
        
        // Constrain action button.
        actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
