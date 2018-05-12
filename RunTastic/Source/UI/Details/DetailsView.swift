//
//  DetailsView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

class DetailsView: UIView {
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup self.
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
