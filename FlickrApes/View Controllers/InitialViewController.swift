//
//  InitialViewController.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController
{
    typealias segues = Constants.Identifiers.Segues
    typealias userDefaultKeys = Constants.UserDefaultKeys
    
    // MARK: - Properties
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        routeUserToNextScreen()
    }
    
    // MARK: - Helpers
    fileprivate func configureView()
    {
        setNeedsStatusBarAppearanceUpdate()
    }
    
    fileprivate func routeUserToNextScreen()
    {
        SessionService.shared.isFirstLaunch() ?
            performSegue(withIdentifier: segues.toIntroScreen, sender: self) :
            performSegue(withIdentifier: segues.toMainScreen, sender: self)
    }
}
