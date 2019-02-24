//
//  UserDefaults+RunTastic.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/28/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation

enum UserDefaultsKey: String {
    case targetPace
}

extension UserDefaults {
    
    // MARK: - Public Properties
    
    var targetPace: TimeInterval {
        get {
            return double(forKey: UserDefaultsKey.targetPace.rawValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKey.targetPace.rawValue)
        }
    }
    
    // MARK: - Public Methods
    
    func registerDefaults() {
        register(defaults: [UserDefaultsKey.targetPace.rawValue: 480])
    }
}
