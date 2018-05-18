//
//  AppDelegate.swift
//  RacYa
//
//  Created by Ryan Crist on 4/22/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import CoreLocation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let locationManager = CLLocationManager()

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Setup global navigation bar appearance.
        UINavigationBar.appearance().isTranslucent = false
        
        // Setup location manager.
        locationManager.requestAlwaysAuthorization()
        
        // Setup main view controller.
        let listViewController = ListViewController()
        let navigationController = UINavigationController(rootViewController: listViewController)
        
        // Setup window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

