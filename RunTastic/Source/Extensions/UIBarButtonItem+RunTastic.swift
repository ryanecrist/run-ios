//
//  UIBarButtonItem+RunTastic.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/28/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    func addTarget(target: AnyObject?, action: Selector) {
        self.target = target
        self.action = action
    }
}
