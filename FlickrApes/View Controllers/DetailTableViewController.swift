//
//  DetailTableViewController.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import UIKit
import SDWebImage
import SafariServices

class DetailTableViewController: UITableViewController
{
    // MARK: - Outlets
    @IBOutlet fileprivate weak var photoImageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var authorLabel: UILabel!
    @IBOutlet fileprivate weak var authorIDLabel: UILabel!
    @IBOutlet fileprivate weak var captureDateLabel: UILabel!
    @IBOutlet fileprivate weak var publishDateLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var tagsLabel: UILabel!
    
    // MARK: - Properties
    var passedPhoto: FlickrPhoto?
    var selectedImage: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Helpers
    fileprivate func configureView()
    {
        guard let mediaLink = passedPhoto?.media?["m"] as? String, let imageURL = URL(string: mediaLink) else { return }
        setSelectedImage(with: imageURL)
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.sd_setShowActivityIndicatorView(true)
        photoImageView.sd_setIndicatorStyle(.gray)
        photoImageView.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "logo"), options: .cacheMemoryOnly, completed: nil)
        
        titleLabel.text = passedPhoto?.title
        authorLabel.text = passedPhoto?.author
        authorIDLabel.text = passedPhoto?.authorID
        captureDateLabel.text = passedPhoto?.dateTaken?.longString()
        publishDateLabel.text = passedPhoto?.datePublished?.longString()
        descriptionLabel.attributedText = passedPhoto?.description?.htmlToAttibutedString()
        tagsLabel.text = passedPhoto?.tags?.replacingOccurrences(of: " ", with: "\t")
    }
    
    fileprivate func setSelectedImage(with url: URL)
    {
        guard let data = try? Data(contentsOf: url) else { return }
        selectedImage = UIImage(data: data)
    }
    
    fileprivate func open(_ link: String)
    {
        guard let linkURL = URL(string: link) else { return }
        let safariVC = SFSafariViewController(url: linkURL)
        safariVC.modalPresentationStyle = .popover
        safariVC.modalTransitionStyle = .coverVertical
        safariVC.preferredBarTintColor = .faOrange
        
        present(safariVC, animated: true, completion: nil)
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        switch indexPath.row {
        case 8:
            if let photoLink = passedPhoto?.link { open(photoLink) }
            
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
