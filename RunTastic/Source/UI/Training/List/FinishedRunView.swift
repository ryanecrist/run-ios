//
//  FinishedRunView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import MapKit
import UIKit

class FinishedRunView: UIView {
    
    // MARK: - Public Properties
    
    var startTimeLabel: UILabel {
        return startTimeItemView.valueLabel
    }
    
    var endTimeLabel: UILabel {
        return endTimeItemView.valueLabel
    }
    
    var distanceLabel: UILabel {
        return distanceItemView.valueLabel
    }
    
    let mapView = MKMapView()
    
    // MARK: - Private Properties
    
    private let startTimeItemView = RunPropertyItemView()
    
    private let endTimeItemView = RunPropertyItemView()
    
    private let distanceItemView = RunPropertyItemView()
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup self.
        backgroundColor = .white
        
        // Setup content stack view.
        let contentStackView = UIStackView(arrangedSubviews: [startTimeItemView,
                                                              endTimeItemView,
                                                              distanceItemView,
                                                              mapView])
        contentStackView.axis = .vertical
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        contentStackView.spacing = 8
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.setCustomSpacing(0, after: mapView)
        
        // Setup start time item view.
        startTimeItemView.titleLabel.text = "Start Time:"
        
        // Setup end time item view.
        endTimeItemView.titleLabel.text = "End Time:"
        
        // Setup distance item view.
        distanceItemView.titleLabel.text = "Distance:"
        
        // Add subviews.
        addSubview(contentStackView)
        
        // Add constraints.
        NSLayoutConstraint.activate([
            
            // Constrain content stack view.
            contentStackView.leftAnchor.constraint(equalTo: leftAnchor),
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.rightAnchor.constraint(equalTo: rightAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
