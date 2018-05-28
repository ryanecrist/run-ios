//
//  PacePickerView.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/28/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

enum PacePickerComponents: Int {
    case minutes
    case seconds
}

class PacePickerView: UIPickerView {
    
    // MARK: - Public Properties
    
    var selectedPace: TimeInterval {
        return TimeInterval(selectedRow(inComponent: PacePickerComponents.minutes.rawValue) * 60 +
                            selectedRow(inComponent: PacePickerComponents.seconds.rawValue))
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup data source and delegate.
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

extension PacePickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
}

extension PacePickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        switch PacePickerComponents(rawValue: component) {
        case .minutes?: return "\(row) min"
        case .seconds?: return "\(row) sec"
        default:        return nil
        }
    }
}

