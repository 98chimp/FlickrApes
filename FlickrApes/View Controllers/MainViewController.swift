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
        WebService.searchPhotos(for: "apes") { [weak self] (photos) in
            
            self?.photos = photos
            self?.photosTableView.reloadSections(IndexSet(integersIn: 0...0), with: .top)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

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
        let cell = tableView.dequeueReusableCell(withIdentifier: cells.photoCell, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
