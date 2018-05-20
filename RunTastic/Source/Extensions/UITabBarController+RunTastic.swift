//
//  UITabBarController+RunTastic.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/19/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    var isTabBarHidden: Bool {
        return self.tabBar.frame.minY == UIScreen.main.bounds.maxY
    }
    
    func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        
        let duration = animated ? 0.25 : 0
        let heightOffset = hidden ? tabBar.frame.height : -tabBar.frame.height
        
        UIView.animate(withDuration: duration) {
            
            self.tabBar.frame = self.tabBar.frame.offsetBy(dx: 0,
                                                           dy: heightOffset)
            
            if let selectedViewController = self.selectedViewController {
                selectedViewController.view.frame.size.height += heightOffset
                selectedViewController.view.layoutIfNeeded()
            }
        }
    }
}
