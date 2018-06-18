//
//  MainViewController.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import UIKit
import M13ProgressSuite

class MainViewController: UIViewController
{
    typealias Cells = Constants.Identifiers.Cells
    typealias Segues = Constants.Identifiers.Segues
    typealias MiscConstants = Constants.Miscellaneous

    // MARK: - Outlets
    @IBOutlet fileprivate weak var photosTableView: UITableView!
    
    // MARK: - Properties
    fileprivate var photos = [FlickrPhoto]()
    fileprivate var selectedIndexPath = IndexPath()
    fileprivate var hud = M13ProgressHUD()
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var tags = MiscConstants.apes

    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureHUD()
        getPublicPhotos()
    }
    
    // MARK: - Networking
    @objc fileprivate func getPublicPhotos()
    {
        hud.show(true)
        
        WebService.searchPhotos(for: tags) { [weak self] (photos) in
            
            self?.hud.hide(true)
            if photos.isEmpty
            {
                self?.present(AlertService.prepareEmptyPhotosResponseAlert(), animated: true, completion: nil)
            }
            else
            {
                self?.photos = photos
                self?.reloadTableView()
            }
        }
    }
    
    // MARK: - Helpers
    fileprivate func configureHUD()
    {
        hud = M13ProgressHUD(progressView: M13ProgressViewRing())
        hud.configure()
        view.addSubview(hud)
    }
    
    fileprivate func reloadTableView()
    {
        photosTableView.reloadSections(IndexSet(integersIn: 0...0), with: .top)
    }
    
    fileprivate func sortPhotos(for selection: Int = 0)
    {
        switch selection {
        case 0:
            photos = photos.sorted { $0.datePublished?.compare($1.datePublished!) == .orderedDescending }

        default:
            photos = photos.sorted { $0.dateTaken?.compare($1.dateTaken!) == .orderedDescending }

        }
        
        reloadTableView()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == Segues.toPhotoDetail
        {
            let destinationVC = segue.destination as? DetailTableViewController
            let photoToPass = photos[selectedIndexPath.row]
            destinationVC?.passedPhoto = photoToPass
        }
    }
    
    // MARK: - Actions
    @IBAction func sortingSegmentedControlTapped(_ sender: UISegmentedControl)
    {
        sortPhotos(for: sender.selectedSegmentIndex)
    }
    
    @IBAction func refreshTable(_ sender: UIBarButtonItem)
    {
        getPublicPhotos()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.photoCell, for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
        
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: Segues.toPhotoDetail, sender: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return MiscConstants.photoCellHeight
    }
}

extension MainViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if searchBar.text == MiscConstants.emptyString
        {
            present(AlertService.prepareEmptySearchTermAlert(), animated: true, completion: nil)
        }
        else
        {
            guard let tags = searchBar.text?.replacingOccurrences(of: MiscConstants.space, with: MiscConstants.comma) else { return }
            self.tags = tags
            getPublicPhotos()
            view.endEditing(true)
            searchBar.text = MiscConstants.emptyString
        }
    }
}
