//
//  SettingsViewController.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/26/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Public Properties
    
    lazy var settingsView = SettingsView()
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Setup title and tab bar item.
        title = "Settings"
        tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "Settings"), selectedImage: #imageLiteral(resourceName: "Settings"))
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO set navigation bar shadow using UIAppearance
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.2
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        navigationController?.navigationBar.layer.shadowRadius = 2.5
    }
}
