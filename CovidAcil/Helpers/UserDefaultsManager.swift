//
//  UserDefaultsManager.swift
//  CovidAcil
//
//  Created by Serhan CANOVA on 26/03/2020.
//  Copyright © 2020 mobilegion. All rights reserved.
//

import UIKit

private let userDefaults = UserDefaults.standard

/* User Defaults */

func setPreference(key: String, value: Any?) {
    userDefaults.set(value, forKey: key)
    userDefaults.synchronize()
}

func setObjectPreference(key: String, value: Any?) {
    userDefaults.set((value != nil ? NSKeyedArchiver.archivedData(withRootObject: value!) : nil), forKey: key)
    userDefaults.synchronize()
}

func getStringPreference(key: String) -> String? {
    if (userDefaults.object(forKey: key) != nil) {
        return userDefaults.string(forKey: key)!
    }
    
    return nil
}

func getIntPreference(key: String) -> Int? {
    if (userDefaults.object(forKey: key) != nil) {
        return userDefaults.integer(forKey: key)
    }
    
    return nil
}

func getBoolPreference(key: String) -> Bool? {
    if (userDefaults.object(forKey: key) != nil) {
        return userDefaults.bool(forKey: key)
    }
    
    return nil
}

func getAnyPreference(key: String) -> Any? {
    if (userDefaults.object(forKey: key) != nil) {
        return userDefaults.object(forKey: key)
    }
    
    return nil
}

func removePreference(key: String) {
    userDefaults.removeObject(forKey: key)
    userDefaults.synchronize()
}

func resetPreferences() {
    let domain = Bundle.main.bundleIdentifier!
    userDefaults.removePersistentDomain(forName: domain)
    userDefaults.synchronize()
}
