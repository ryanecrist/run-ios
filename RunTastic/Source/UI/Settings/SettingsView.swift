//
//  SettingsView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/28/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // TODO
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
