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
        
        // Setup global navigation/tab bar appearance.
        UINavigationBar.appearance().barTintColor = .primary
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UITabBar.appearance().isTranslucent = false
        
        // Setup location manager.
        locationManager.requestAlwaysAuthorization()
        
        // Setup main view controller.
        let tabBarController = UITabBarController()
        tabBarController.viewControllers =
            [UINavigationController(rootViewController: MapViewController()),
             UINavigationController(rootViewController: ListViewController())]

        // Setup window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.tintColor = UIColor(named: "Primary")
        window?.makeKeyAndVisible()
        
        return true
    }
}

