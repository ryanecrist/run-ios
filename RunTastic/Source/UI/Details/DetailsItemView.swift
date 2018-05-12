//
//  DetailsItemView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

class DetailsItemView: UIView {
    
    // MARK: - Public Properties
    
    let titleLabel = UILabel()
    
    let valueLabel = UILabel()
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup content stack view.
        let contentStackView = UIStackView()
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews.
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(valueLabel)
        addSubview(contentStackView)
        
        // Add constraints.
        NSLayoutConstraint.activate([
            
            // Constrain content stack view.
            contentStackView.leftAnchor.constraint(equalTo: leftAnchor),
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.rightAnchor.constraint(equalTo: rightAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Constrain labels.
            valueLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
