//
//  AlertService.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98%Chimp. All rights reserved.
//

import UIKit
import MessageUI

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
        let alert = UIAlertController(title: "Uh, oh!", message: "Seems like something went wrong while fetching the image you requested.\nPlease try your search again later.", preferredStyle: .alert)
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

    static func prepareEmailComposerFinishedAlert(with result: MFMailComposeResult, and error: Error?) -> UIAlertController
    {
        var message = emptyString
        var title = emptyString
        
        switch result {
        case .sent:
            title = "Woohoo!"
            message = "Seems like your email was sent smoothly!\nRembmer, sharing is caring!"
            
        case .saved:
            title = "Okay, got it!"
            message = "You're not ready to send that email just yet.\nWhen you are, remember to access your draft message from your favourite email app."

        case .failed:
            title = "Uh, oh!"
            message = "Seems like something went wrong while sending your email message.\n\n\(error?.localizedDescription ?? "unknown error")\nnPlease try sending it again later."
            
        default:
            title = "Aye aye!"
            message = "Your draft message was deleted.\nNothing to send."
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(withTitle: "Okay", style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
    
    static func prepareEmailCannotBeSentAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: "Whoops!", message: "Seems like you cannot send emails on this device.\nPlease make sure your device is set up correctly to send and receive emails and try again.", preferredStyle: .alert)
        alert.addAction(withTitle: "Okay", style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
}
