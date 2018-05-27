//
//  TrainingViewController.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/26/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

class TrainingViewController: UITableViewController {
    
    // MARK: - Public Properties
    
    var runs: [Run] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Setup title and tab bar item.
        title = "Training"
        tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "Training"), selectedImage: #imageLiteral(resourceName: "Training"))
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register table view cells.
        tableView.register(RunTableViewCell.self,
                           forCellReuseIdentifier: RunTableViewCell.identifier)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RunTableViewCell.identifier,
                                                 for: indexPath) as! RunTableViewCell
        let run = runs[indexPath.row]
        
//        cell.textLabel?.text = "\(run.id)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let run = runs[indexPath.row]
//        let detailsViewController = DetailsViewController(runId: run.id)
//        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
