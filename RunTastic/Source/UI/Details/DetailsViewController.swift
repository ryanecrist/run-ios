//
//  DetailsViewController.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    lazy var detailsView = DetailsView()
    
    let runId: Int
    
    init(runId: Int) {
        self.runId = runId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
 
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title.
        title = "Run \(runId)"
        
        // Get run.
        RunTasticAPI.getRun(with: runId).start() { (response: HTTPResponse<Run>) in
            
            if let run = response.value {
            
                // Get run start time.
                if let startTime = run.startTime {
                    self.detailsView.startTimeLabel.text = "\(startTime)"
                } else {
                    self.detailsView.startTimeLabel.text = "N/A"
                }
                
                // Get run end time.
                if let endTime = run.endTime {
                    self.detailsView.endTimeLabel.text = "\(endTime)"
                } else {
                    self.detailsView.endTimeLabel.text = "N/A"
                }
                
                // Get run distance.
                if let distance = run.distance {
                    self.detailsView.distanceLabel.text = "\(distance)"
                } else {
                    self.detailsView.distanceLabel.text = "N/A"
                }
            }
        }
    }
}
