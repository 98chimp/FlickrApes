//
//  AppDelegate.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-26.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    // MARK: - Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        configureAppearance()
        return true
    }

    // MARK: - Helpers
    fileprivate func configureAppearance()
    {
        UIApplication.shared.statusBarStyle = .lightContent
        
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().shadowImage = UIImage.with(color: .faOrange)
        UINavigationBar.appearance().barTintColor = .faOrange
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
                                                            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 22.0, weight: .thin)]
    }
}

