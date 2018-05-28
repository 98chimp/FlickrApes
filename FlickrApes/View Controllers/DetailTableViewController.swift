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
    public var passedPhoto: FlickrPhoto?
    fileprivate var selectedImage: UIImage?
    fileprivate let imagePicker = UIImagePickerController()
    
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
        tagsLabel.text = passedPhoto?.tags?.replacingOccurrences(of: space, with: tagSeparator)
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
        
        present(safariVC, animated: true)
    }
    
    fileprivate func showOptions()
    {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(withTitle: "Save Photo in Image Gallery", style: .default) { [weak self] in
            
            self?.saveImageToPhotoLibrary()
        }
        
        actionSheet.addAction(withTitle: "Open Photo in Image Browser", style: .default) { [weak self] in
            
            self?.openImageInSystemBrowser()
        }
        
        actionSheet.addAction(withTitle: "Share Photo by Email", style: .default) { [weak self] in
            
            self?.sharePhotoByEmail()
        }
        
        actionSheet.addAction(withTitle: "Cancel", style: .cancel, handler: nil)
        
        present(actionSheet, animated: true)
    }
    
    fileprivate func saveImageToPhotoLibrary()
    {
        if let image = selectedImage
        {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        else
        {
            showMissingImageAlert()
        }
    }
    
    fileprivate func openImageInSystemBrowser()
    {
        if let _ = selectedImage
        {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .savedPhotosAlbum
            present(imagePicker, animated: true)
        }
        else
        {
            showMissingImageAlert()
        }
    }
    
    fileprivate func sharePhotoByEmail()
    {
        if let image = selectedImage
        {
            print(image.size)
            print("share button tapped")
        }
        else
        {
            showMissingImageAlert()
        }
    }
    
    fileprivate func showMissingImageAlert()
    {
        present(AlertService.prepareMissingImageAlert(), animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func optionsButtonTapped(_ sender: UIBarButtonItem)
    {
        showOptions()
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

extension DetailTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer)
    {
        if let error = error
        {
            present(AlertService.prepareImageSaveErrorAlert(with: error), animated: true)
        }
        else
        {
            present(AlertService.prepareImageSaveSuccessAlert(), animated: true)
        }
    }
}
