//
//  DetailsView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import MapKit
import UIKit

class DetailsView: UIView {
    
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
    
    let startButton = UIButton()
    
    let stopButton = UIButton()
    
    // MARK: - Private Properties
    
    private let startTimeItemView = DetailsItemView()
    
    private let endTimeItemView = DetailsItemView()
    
    private let distanceItemView = DetailsItemView()
    
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
                                                              mapView,
                                                              startButton,
                                                              stopButton])
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
        
        // Setup start button.
        startButton.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
        startButton.isHidden = true
        startButton.setTitle("START", for: .normal)
        
        // Setup stop button.
        stopButton.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
        stopButton.isHidden = true
        stopButton.setTitle("STOP", for: .normal)
        
        // Add subviews.
        addSubview(contentStackView)
        
        // Add constraints.
        NSLayoutConstraint.activate([
            
            // Constrain content stack view.
            contentStackView.leftAnchor.constraint(equalTo: leftAnchor),
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.rightAnchor.constraint(equalTo: rightAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            // Constrain buttons.
            startButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.heightAnchor.constraint(equalTo: startButton.heightAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
