//
//  WebService.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98%Chimp. All rights reserved.
//

import Foundation
import Alamofire

class WebService
{
    typealias keys = Constants.Web.Keys
    typealias paths = Constants.Web.Paths
    
    static func searchPhotos(for tags: String, completion: @escaping (_ photos: [FlickrPhoto]) -> Void)
    {
        let params = [keys.format:  "json",
                      keys.tags:    tags]
        
        Alamofire.request(paths.publicPhotos, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            
            var flickrPhotos = [FlickrPhoto]()
            
            let jsonString = response.value
            let cleanedUpJSONString = jsonString?.dropFirst(15).dropLast()
            guard let data = cleanedUpJSONString?.data(using: .utf8),
                let photosDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let rawPhotos = photosDictionary?["items"] as? [[String: Any]]
                else { return }
            
            for photoDict in rawPhotos
            {
                let photo = FlickrPhoto().parse(with: photoDict)
                flickrPhotos.append(photo)
            }
            
            completion(flickrPhotos)
        }
    }
}
