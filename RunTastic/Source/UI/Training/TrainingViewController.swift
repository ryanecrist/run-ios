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
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy 'at' h:mm a"
        return dateFormatter
    }()
    
    var runs: [RunDTO] = [] {
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
        
        // TODO set navigation bar shadow using UIAppearance
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.2
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        navigationController?.navigationBar.layer.shadowRadius = 2.5
        
        // Setup refresh control.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.refreshControl = refreshControl
        
        // Register table view cells.
        tableView.register(RunTableViewCell.self,
                           forCellReuseIdentifier: RunTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Get runs.
        RunTasticAPI.getRuns().start() { (response: HTTPResponse<[RunDTO]>) in
            self.runs = response.value ?? []
        }
    }
    
    // MARK: - Action Handlers
    
    @objc
    func refresh(_ sender: UIRefreshControl) {
        
        // Get runs.
        RunTasticAPI.getRuns().start() { (response: HTTPResponse<[RunDTO]>) in
            self.runs = response.value ?? []
            sender.endRefreshing()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RunTableViewCell.identifier,
                                                 for: indexPath)
        
        let run = runs[indexPath.row]
        
        if let startTimeMs = run.startTime {
            cell.textLabel?.text = dateFormatter.string(from: Date(millisecondsSinceEpoch: startTimeMs))
        }
        
        // TODO create utility class for unit conversions
        cell.detailTextLabel?.text = String(format: "%.2f mi", (run.distance ?? 0) * 0.000621371192)
        
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
