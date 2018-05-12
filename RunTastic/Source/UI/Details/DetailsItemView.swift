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
        contentStackView.axis = .vertical
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup labels.
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        
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
            valueLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
