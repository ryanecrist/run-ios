//
//  MapView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/19/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import MapKit
import UIKit

class RunView: UIView {
    
    let headerView = RunHeaderView()
    
    let mapView = MKMapView()
    
    let actionButton = UIButton()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup self.
        backgroundColor = .white
        
        // Setup map view.
        mapView.showsCompass = false
        
        // Setup compass button.
        let compassButton = MKCompassButton(mapView: mapView)
        compassButton.compassVisibility = .adaptive
        compassButton.layer.shadowColor = UIColor.black.cgColor
        compassButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        compassButton.layer.shadowOpacity = 0.2
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup user tracking button.
        let userTrackingButton = MKUserTrackingButton(mapView: mapView)
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
        
        let stackView = UIStackView(arrangedSubviews: [headerView, mapView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews.
        mapView.addSubview(userTrackingButton)
        mapView.addSubview(compassButton)
        mapView.addSubview(actionButton)
        addSubview(stackView)
        
        // Move the header view on top.
        stackView.bringSubview(toFront: headerView)
        
        // Constrain stack view.
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        // Constrain user tracking button.
        userTrackingButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 8).isActive = true
        userTrackingButton.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -8).isActive = true
        
        // Constrain compass button.
        compassButton.topAnchor.constraint(equalTo: userTrackingButton.bottomAnchor, constant: 8).isActive = true
        compassButton.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -8).isActive = true
        compassButton.widthAnchor.constraint(equalTo: userTrackingButton.widthAnchor).isActive = true
        compassButton.heightAnchor.constraint(equalTo: compassButton.widthAnchor).isActive = true
        
        // Constrain action button.
        actionButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -8).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
