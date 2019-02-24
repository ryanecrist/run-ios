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
        UINavigationBar.appearance().tintColor = .white
        UITabBar.appearance().isTranslucent = false
        
        // Register defaults.
        UserDefaults.standard.registerDefaults()
        
        // Setup location manager.
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
        
        // Setup main view controller.
        let tabBarController = UITabBarController()
        tabBarController.viewControllers =
            [RunViewController(),
             UINavigationController(rootViewController: TrainingViewController()),
             UINavigationController(rootViewController: SettingsViewController())]

        // Setup window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.tintColor = .primary
        window?.makeKeyAndVisible()
        
        return true
    }
}

