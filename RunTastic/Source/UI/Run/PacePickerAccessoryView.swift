//
//  PacePickerAccessoryView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/28/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

class PacePickerAccessoryView: UIToolbar {
    
    // MARK: - Public Properties
    
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Setup items.
        items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                 target: nil,
                                 action: nil),
                 doneButton]
        tintColor = .primary
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
