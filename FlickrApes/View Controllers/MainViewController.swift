//
//  MainViewController.swift
//  FlickrApes
//
//  Created by Shahin on 2018-05-27.
//  Copyright © 2018 98Chimp. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    typealias cells = Constants.Identifiers.Cells
    typealias segues = Constants.Identifiers.Segues

    // MARK: - Outlets
    @IBOutlet fileprivate weak var photosTableView: UITableView!
    
    // MARK: - Properties
    fileprivate var photos = [FlickrPhoto]()
    fileprivate var selectedIndexPath = IndexPath()
    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getPublicPhotos()
    }
    
    // MARK: - Helpers
    fileprivate func getPublicPhotos(with tags: String = "apes")
    {
        WebService.searchPhotos(for: tags) { [weak self] (photos) in
            
            self?.photos = photos
            self?.reloadTableView()
        }
    }
    
    fileprivate func reloadTableView()
    {
        photosTableView.reloadSections(IndexSet(integersIn: 0...0), with: .top)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == segues.toPhotoDetail
        {
            let destinationVC = segue.destination as? DetailTableViewController
            let photoToPass = photos[selectedIndexPath.row]
            destinationVC?.passedPhoto = photoToPass
        }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cells.photoCell, for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
        
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: segues.toPhotoDetail, sender: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return photoCellHeight
    }
}
