//
//  AlertService.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98%Chimp. All rights reserved.
//

import UIKit
import MessageUI

enum AlertTitles: String
{
    case error = "Uh, oh!"
    case success = "Woohoo!"
    case confirm = "Okay, got it!"
    case ayeAye = "Aye aye!"
    case whoops = "Whoops!"
}

enum AlertMessages: String
{
    case emptySearch = "Please make sure you enter some text first."
    case emptyPhotosResponse = "Seems like something went wrong with your last network request.\nPlease try your search again later."
    case missingImage = "Seems like something went wrong while fetching the image you requested.\nPlease try your search again later."
    case imageSaveError = "Please try saving again later."
    case imageSaveSuccess = "Seems like everything went smoothly!\nOn to saving the next photo."
    case emailSentSuccess = "Seems like your email was sent smoothly!\nRembmer, sharing is caring!"
    case emailSavedSuccess = "You're not ready to send that email just yet.\nWhen you are, remember to access your draft message from your favourite email app."
    case emailFailed = "Seems like something went wrong while sending your email message.\nPlease try sending it again later.\n\n"
    case emailDraftDeleted = "Your draft message was deleted.\nNothing to send."
    case cannotSendEmail = "Seems like you cannot send emails on this device.\nPlease make sure your device is set up correctly to send and receive emails and try again."
}

enum AlertButtonTitles: String
{
    case gotIt = "Got it!"
    case okay = "Okay"
}

class AlertService
{
    typealias MiscConstants = Constants.Miscellaneous
    
    static func prepareEmptySearchTermAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: AlertTitles.error.rawValue, message: AlertMessages.emptySearch.rawValue, preferredStyle: .alert)
        alert.addAction(withTitle: AlertButtonTitles.gotIt.rawValue, style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
    
    static func prepareEmptyPhotosResponseAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: AlertTitles.error.rawValue, message: AlertMessages.emptyPhotosResponse.rawValue, preferredStyle: .alert)
        alert.addAction(withTitle: AlertButtonTitles.okay.rawValue, style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
    
    static func prepareMissingImageAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: AlertTitles.error.rawValue, message: AlertMessages.missingImage.rawValue, preferredStyle: .alert)
        alert.addAction(withTitle: AlertButtonTitles.okay.rawValue, style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
    
    static func prepareImageSaveErrorAlert(with error: Error) -> UIAlertController
    {
        let alert = UIAlertController(title: AlertTitles.error.rawValue, message: "\(error.localizedDescription).\n\(AlertMessages.missingImage.rawValue)", preferredStyle: .alert)
        alert.addAction(withTitle: AlertButtonTitles.okay.rawValue, style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
    
    static func prepareImageSaveSuccessAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: AlertTitles.success.rawValue, message: AlertMessages.imageSaveSuccess.rawValue, preferredStyle: .alert)
        alert.addAction(withTitle: AlertButtonTitles.okay.rawValue, style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }

    static func prepareEmailComposerFinishedAlert(with result: MFMailComposeResult, and error: Error?) -> UIAlertController
    {
        var message = MiscConstants.emptyString
        var title = MiscConstants.emptyString
        
        switch result {
        case .sent:
            title = AlertTitles.success.rawValue
            message = AlertMessages.emailSentSuccess.rawValue
            
        case .saved:
            title = AlertTitles.confirm.rawValue
            message = AlertMessages.emailSavedSuccess.rawValue

        case .failed:
            title = AlertTitles.error.rawValue
            message = "\(AlertMessages.emailFailed.rawValue)\(error?.localizedDescription ?? MiscConstants.unknownError)"
            
        default:
            title = AlertTitles.ayeAye.rawValue
            message = AlertMessages.emailDraftDeleted.rawValue
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(withTitle: AlertButtonTitles.okay.rawValue, style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
    
    static func prepareEmailCannotBeSentAlert() -> UIAlertController
    {
        let alert = UIAlertController(title: AlertTitles.whoops.rawValue, message: AlertMessages.cannotSendEmail.rawValue, preferredStyle: .alert)
        alert.addAction(withTitle: AlertButtonTitles.okay.rawValue, style: .cancel, handler: nil)
        alert.view.tintColor = .faOrange
        
        return alert
    }
}
