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
        static let main = "Main"
    }
    
    struct ViewControllers
    {
        static let initialVC = "Initial View Controller"
        static let introVC = "Intro View Controller"
        static let mainVC = "Main View Controller"
        static let detailVC = "Photo Detail View Controller"
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
            static let toPhotoDetail = "toPhotoDetail"
        }
    }
    
    struct UserDefaultKeys
    {
        static let hasLaunchedBefore = "hasLaunchedBefore"
    }
    
    struct Photo
    {
        static let title = "title"
        static let author = "author"
        static let authorID = "author_id"
        static let link = "link"
        static let media = "media"
        static let description = "description"
        static let dateTaken = "date_taken"
        static let datePublished = "published"
        static let tags = "tags"
    }
    
    struct Miscellaneous
    {
        static let photoCellHeight: CGFloat = 100.0
        static let emptyString = ""
        static let space = " "
        static let tagSeparator = "  |  "
        static let comma = ", "
        static let apes = "apes"
        static let unknownError = "unknown error"
    }
    
    struct Web
    {
        struct Paths
        {
            static let publicPhotos = "https://api.flickr.com/services/feeds/photos_public.gne"
        }
        
        struct Keys
        {
            static let format = "format"
            static let tags = "tags"
        }
    }
}
