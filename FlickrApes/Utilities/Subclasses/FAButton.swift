//
//  FAButton.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98%Chimp. All rights reserved.
//

import UIKit
@IBDesignable

class FAButton: UIButton
{
    override func awakeFromNib()
    {
        super.awakeFromNib()
        clipsToBounds = true
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
//        titleLabel?.numberOfLines = 1
//        titleLabel?.adjustsFontSizeToFitWidth = true;
//        titleLabel?.lineBreakMode = .byClipping
    }
}
