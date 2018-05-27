//
//  TrainingViewController.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/26/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Setup title and tab bar item.
        title = "Training"
        tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "Training"), selectedImage: #imageLiteral(resourceName: "Training"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
