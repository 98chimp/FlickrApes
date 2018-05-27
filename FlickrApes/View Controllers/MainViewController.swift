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
    @IBOutlet weak var photosTableView: UITableView!
    
    // MARK: - Properties
    fileprivate var photos = [Photo]()
    fileprivate var selectedIndexPath = IndexPath()
    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

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
        return 1
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
