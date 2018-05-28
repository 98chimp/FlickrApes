//
//  PhotoTableViewCell.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-28.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell
{
    // MARK: - Outlets
    @IBOutlet fileprivate weak var photoImageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var authorLabel: UILabel!
    
    // MARK: - Helpers
    func configure(with photo: FlickrPhoto)
    {
        titleLabel.text = photo.title
        authorLabel.text = "by: \(photo.author ?? "Anonymous")"
        
        guard let mediaLink = photo.media?["m"] as? String, let imageURL = URL(string: mediaLink) else { return }
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.sd_setShowActivityIndicatorView(true)
        photoImageView.sd_setIndicatorStyle(.gray)
        photoImageView.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "logo"), options: .cacheMemoryOnly, completed: nil)
    }

}
