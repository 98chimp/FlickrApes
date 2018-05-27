//
//  DetailTableViewController.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import UIKit

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
    var passedPhoto: Photo?
    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = false
    }
    
    // MARK: - Helpers
    fileprivate func configureView()
    {
        
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        switch indexPath.row {
        case 8:
            print("link was tapped")
            
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
