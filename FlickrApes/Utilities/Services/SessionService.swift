//
//  SessionService.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98%Chimp. All rights reserved.
//

import Foundation

class SessionService
{
    fileprivate typealias userDefaultKeys = Constants.UserDefaultKeys
    
    // MARK: - Properties
    static let shared = SessionService()
    
    // MARK: - User Defaults
    func recordFirstLaunch()
    {
        UserDefaults.standard.set(true, forKey: userDefaultKeys.hasLaunchedBefore)
        UserDefaults.standard.synchronize()
    }
    
    func isFirstLaunch() -> Bool
    {
        let keys = UserDefaults.standard.dictionaryRepresentation().keys
        let firstLaunchKey = userDefaultKeys.hasLaunchedBefore
        let isFirstLaunch = !keys.contains(firstLaunchKey)
        
        return isFirstLaunch
    }
}
