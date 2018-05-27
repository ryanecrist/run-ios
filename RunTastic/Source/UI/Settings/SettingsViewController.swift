//
//  SettingsViewController.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/26/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

import UIKit

class SettingsViewController: UIViewController {
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Setup title and tab bar item.
        title = "Settings"
        tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "Settings"), selectedImage: #imageLiteral(resourceName: "Settings"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
