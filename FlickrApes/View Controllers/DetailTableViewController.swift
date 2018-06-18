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
import MessageUI

class DetailTableViewController: UITableViewController
{
    typealias MiscConstants = Constants.Miscellaneous
    
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
    fileprivate var selectedImageData: Data?
    fileprivate let imagePicker = UIImagePickerController()
    fileprivate let indexOfPhotoLink = 8
    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Helpers
    fileprivate func configureView()
    {
        titleLabel.text = passedPhoto?.title
        authorLabel.text = passedPhoto?.author
        authorIDLabel.text = passedPhoto?.authorID
        captureDateLabel.text = passedPhoto?.dateTaken?.longString()
        publishDateLabel.text = passedPhoto?.datePublished?.longString()
        descriptionLabel.attributedText = passedPhoto?.description?.htmlToAttibutedString()
        tagsLabel.text = passedPhoto?.tags?.replacingOccurrences(of: MiscConstants.space, with: MiscConstants.tagSeparator)
        
        guard let mediaLink = passedPhoto?.media?["m"] as? String, let imageURL = URL(string: mediaLink) else { return }
        setSelectedImage(with: imageURL)
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.sd_setShowActivityIndicatorView(true)
        photoImageView.sd_setIndicatorStyle(.gray)
        photoImageView.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "logo"), options: .cacheMemoryOnly, completed: nil)
    }
    
    fileprivate func setSelectedImage(with url: URL)
    {
        if let data = try? Data(contentsOf: url)
        {
            selectedImageData = data
            selectedImage = UIImage(data: data)
        }
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
        actionSheet.addAction(withTitle: "Save Photo in Photo Library", style: .default) { [weak self] in
            
            self?.saveImageToPhotoLibrary()
        }
        
        actionSheet.addAction(withTitle: "Open Photo Library", style: .default) { [weak self] in
            
            self?.openImageInSystemBrowser()
        }
        
        actionSheet.addAction(withTitle: "Share Photo by Email", style: .default) { [weak self] in
            
            self?.sharePhotoByEmail()
        }
        
        actionSheet.addAction(withTitle: "Cancel", style: .cancel, handler: nil)
        actionSheet.view.tintColor = .faOrange
        
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
            showPhotoLibrary()
        }
        else
        {
            showMissingImageAlert()
        }
    }
    
    fileprivate func sharePhotoByEmail()
    {
        if let imageData = selectedImageData
        {
            sendEmail(with: imageData)
        }
        else
        {
            showMissingImageAlert()
        }
    }
    
    fileprivate func showPhotoLibrary()
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true)
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
        case indexOfPhotoLink:
            if let photoLink = passedPhoto?.link { open(photoLink) }
            
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - Image Picker Delegate
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
            let alert = AlertService.prepareImageSaveSuccessAlert()
            
            alert.addAction(withTitle: "Go to Photo Library", style: .default) { [weak self] in
                
                self?.showPhotoLibrary()
            }
            
            present(alert, animated: true)
        }
    }
}

extension DetailTableViewController: MFMailComposeViewControllerDelegate
{
    fileprivate func sendEmail(with imageData: Data)
    {
        if MFMailComposeViewController.canSendMail()
        {
            let emailVC = MFMailComposeViewController()
            emailVC.mailComposeDelegate = self;
            emailVC.setSubject("Look!")
            emailVC.setMessageBody("[Your message goes here]", isHTML: false)
            emailVC.addAttachmentData(imageData, mimeType: "image/png", fileName: "imageName.png")
            emailVC.navigationBar.tintColor = .white
            
            present(emailVC, animated: true)
        }
        else
        {
            present(AlertService.prepareEmailCannotBeSentAlert(), animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        let alert = AlertService.prepareEmailComposerFinishedAlert(with: result, and: error)
        controller.dismiss(animated: true)
        present(alert, animated: true)
    }
}
