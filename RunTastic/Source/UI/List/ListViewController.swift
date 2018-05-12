//
//  ListViewController.swift
//  RacYa
//
//  Created by Ryan Crist on 5/7/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    // MARK: - Public Properties
    
    var runs: [Run] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Runs"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(createRun))
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        self.refreshControl = refreshControl
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "runCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RunTasticAPI.getRuns().start() { (response: HTTPResponse<[Run]>) in
                
            if let runs = response.value {
                self.runs = runs
            }
        }
    }
    
    // MARK: - Action Handlers
    
    @objc
    func createRun(_ sender: UIBarButtonItem) {
        
        RunTasticAPI.createRun().start() { (response: HTTPResponse<String>) in

            if let rawRunId = response.value,
                let runId = Int(rawRunId) {
                let detailsViewController = DetailsViewController(runId: runId)
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            }
        }
    }
    
    @objc
    func refreshList(_ sender: UIRefreshControl) {
        
        RunTasticAPI.getRuns().start() { (response: HTTPResponse<[Run]>) in
                
            if let runs = response.value {
                self.runs = runs
            }
            
            sender.endRefreshing()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "runCell", for: indexPath)
        let run = runs[indexPath.row]

        cell.textLabel?.text = "\(run.id)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let run = runs[indexPath.row]
        let detailsViewController = DetailsViewController(runId: run.id)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
