//
//  FinishedRunViewController.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/28/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import CoreLocation
import UIKit

class FinishedRunViewController: UIViewController {
    
    // MARK: - Public Properties
    
    lazy var finishedRunView = FinishedRunView()
    
    let mapManager = MapManager()
    
    let run: RunDTO
    
    // MARK: - Initializers
    
    init(run: RunDTO) {
        self.run = run
        super.init(nibName: nil, bundle: nil)
        
        // Setup title and tab bar item.
        title = "Run"
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = finishedRunView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup map manager.
        mapManager.mapView = finishedRunView.mapView
        
        // Update labels.
        finishedRunView.startTimeLabel.text = Formatter.date(run.startTime!)
        finishedRunView.endTimeLabel.text = Formatter.date(run.endTime!)
        finishedRunView.distanceLabel.text = Formatter.distance(run.distance!)
        
        // Get run.
        RunTasticAPI.getRunRoute(with: run.id).start() { (response: HTTPResponse<[LocationDTO]>) in
            
            // Abort if there is no route.
            guard let route = response.value else { return }
            
            // Add the route to the map.
            self.mapManager.addRouteToMap(route)
        }
    }
}
