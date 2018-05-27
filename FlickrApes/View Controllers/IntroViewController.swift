//
//  IntroViewController.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController
{
    // MARK: - Outlets
    @IBOutlet fileprivate weak var okayButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Helpers
    fileprivate func configureView()
    {
//        okayButton.layer.cornerRadius = 5.0
//        okayButton.layer.
    }
    
    // MARK: - Actions
    @IBAction fileprivate func okayButtonTapped(_ sender: UIButton)
    {
        SessionService.shared.recordFirstLaunch()
        dismiss(animated: true, completion: nil)
    }
}
