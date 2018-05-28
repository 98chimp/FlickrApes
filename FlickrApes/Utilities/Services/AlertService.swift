//
//  AlertService.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98%Chimp. All rights reserved.
//

import UIKit

class AlertService
{    
    static func prepareEmptySearchTermAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: "Uh, oh!", message: "Please make sure you enter some text first.", preferredStyle: .alert)
        alert.addAction(withTitle: "Got it!", style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
    
    static func prepareEmptyPhotosResponseAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: "Uh, oh!", message: "Seems like something went wrong with your last network request.\nPlease try your search again later.", preferredStyle: .alert)
        alert.addAction(withTitle: "Okay", style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
    
    static func prepareMissingImageAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: "Uh, oh!", message: "Seems like something went wrong fetching the image you requested.\nPlease try your search again later.", preferredStyle: .alert)
        alert.addAction(withTitle: "Okay", style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
    
    static func prepareImageSaveErrorAlert(with error: Error) -> UIAlertController
    {
        let alert = UIAlertController(title: "Uh, oh!", message: "\(error.localizedDescription).\nPlease try saving again later.", preferredStyle: .alert)
        alert.addAction(withTitle: "Okay", style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
    static func prepareImageSaveSuccessAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: "Woohoo!", message: "Seems like everything went smoothly!\nOn to saving the next photo.", preferredStyle: .alert)
        alert.addAction(withTitle: "Okay", style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }

}
