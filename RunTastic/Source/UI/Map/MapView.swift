//
//  MapView.swift
//  RacYa
//
//  Created by Ryan Crist on 4/22/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import MapKit
import UIKit

class MapView: UIView {

    let mapView = MKMapView()
    
    let startStopButton = UIButton()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup content stack view.
        let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup start/stop button.
        startStopButton.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
        startStopButton.setTitle("START", for: .normal)
        
        // Add subviews.
        contentStackView.addArrangedSubview(mapView)
        contentStackView.addArrangedSubview(startStopButton)
        addSubview(contentStackView)
        
        // Constrain content stack view.
        contentStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // Constrain start/stop button.
        startStopButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
