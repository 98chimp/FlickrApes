//
//  FlickrPhoto.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import Foundation

class FlickrPhoto
{
    typealias keys = Constants.Photo
    
    // MARK: - Properties
    var title: String?
    var author: String?
    var authorID: String?
    var link: String?
    var description: String?
    var tags: String?
    var media: [String: Any]?
    var dateTaken: Date?
    var datePublished: Date?
    
    // MARK: - Parsers
    func parse(with dict: [String: Any]) -> FlickrPhoto
    {
        let photo = FlickrPhoto()
        
        photo.title = dict[keys.title] as? String
        photo.author = dict[keys.author] as? String
        photo.authorID = dict[keys.authorID] as? String
        photo.description = dict[keys.description] as? String
        photo.link = dict[keys.link] as? String
        photo.tags = dict[keys.tags] as? String
        photo.media = dict[keys.media] as? [String: Any]
        let dateTakenString = dict[keys.dateTaken] as? String
        photo.dateTaken = dateTakenString?.toDate()
        let datePublishedString = dict[keys.datePublished] as? String
        photo.datePublished = datePublishedString?.toDate()
        
        return photo
    }
}
