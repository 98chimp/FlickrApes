//
//  M13ProgressHUD+Extensions.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-28.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import Foundation
import M13ProgressSuite

extension M13ProgressHUD
{
    func configure(with status: String = "Processing")
    {
        self.progressViewSize = CGSize(width: 60, height: 60)
        self.animationPoint = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        self.primaryColor = .green
        self.secondaryColor = .faOrange
        self.status = status
        self.indeterminate = true
        self.setProgress(0.1, animated: true)
    }
    
    func presentSuccess(with status: String = "Success!")
    {
        self.status = status
        self.setProgress(1.0, animated: true)
        self.indeterminate = false
        self.perform(M13ProgressViewActionSuccess, animated: true)
    }

}
