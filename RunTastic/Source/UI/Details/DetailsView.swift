//
//  DetailsView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

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
        let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup start time item view.
        startTimeItemView.titleLabel.text = "Start Time:"
        
        // Setup end time item view.
        endTimeItemView.titleLabel.text = "End Time:"
        
        // Setup distance item view.
        distanceItemView.titleLabel.text = "Distance:"
        
        // Add subviews.
        contentStackView.addArrangedSubview(startTimeItemView)
        contentStackView.addArrangedSubview(endTimeItemView)
        contentStackView.addArrangedSubview(distanceItemView)
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
