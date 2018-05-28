//
//  String+Extensions.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-28.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import UIKit

extension String
{
    func toDate() -> Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        guard let date = dateFormatter.date(from:self) else { return nil }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let finalDate = calendar.date(from:components)
        
        return finalDate
    }
    
    func htmlToAttibutedString() -> NSAttributedString
    {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        guard let attributedString = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                                                                             NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            else { return NSAttributedString() }
        return attributedString
    }
}
