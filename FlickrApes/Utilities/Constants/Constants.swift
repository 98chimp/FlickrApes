//
//  Constants.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98%Chimp. All rights reserved.
//

import UIKit


func execute(after delay:Double, closure:@escaping ()->())
{
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

struct Constants
{
    struct Storyboards
    {
        static let initial = "Initial"
        static let signin = "Signin"
        static let welcome = "Welcome"
        static let main = "Main"
    }
    
    struct ViewControllers
    {
        static let initialVC = "InitialViewController"
        static let singinTVC = "SigninTableViewController"
        static let signupTVC = "SignupTableViewController"
        static let forgotPasswordTVC = "ForgotPasswordTableViewController"
        static let welcome1VC = "Welcome1VC"
        static let welcome2VC = "Welcome2VC"
        static let welcome3VC = "Welcome3VC"
        static let welcome4VC = "Welcome4VC"
        static let mainVC = "MainViewController"
        static let newPostVC = "NewPostViewController"
    }

    struct Identifiers
    {
        struct Cells
        {
            static let photoCell = "photoCell"
        }
        
        struct Segues
        {
            static let toMainScreen = "toMainScreen"
            static let toIntroScreen = "toIntroScreen"
        }
    }
    
    struct UserDefaultKeys
    {
        static let hasLaunchedBefore = "hasLaunchedBefore"
    }
    
    struct Models
    {
        struct User
        {
            static let firstName = "firstName"
            static let lastName = "lastName"
            static let birthDate = "birthDate"
            static let bofHandle = "bofHandle"
            static let email = "email"
            static let password = "password"
            static let token = "token"
        }
        
        struct Post
        {
            static let content = "content"
            static let poster = "poster"
        }
    }
    
    struct AccessibilityLabels
    {
        static let email = "email"
        static let password = "password"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let passwordConfirm = "passwordConfirm"
        static let date = "date"
        static let imageCell = "imageCell"
        static let singinButton = "signinButton"
        static let signupButton = "signupButton"
        static let learnButton = "learnButton"
        static let forgotButton = "forgotButton"
        static let cancelButton = "cancelButton"
        static let skipButton = "skipButton"
        static let doneButton = "doneButton"
        static let wecomeImage = "welcomeImage"
        static let welcomeLabel = "welcomeLabel"
        static let signupImage = "signupImage"
        static let signupLabel = "signupLabel"
        static let inviteImage = "inviteImage"
        static let inviteLabel = "inviteLabel"
        static let bofImage = "bofImage"
        static let bofLabel = "bofLabel"
    }
}
