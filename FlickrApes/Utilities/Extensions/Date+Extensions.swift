//
//  Date+Extensions.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-28.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import Foundation

extension Date
{
    func longString() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self)
    }
    
    func shortString() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
}
