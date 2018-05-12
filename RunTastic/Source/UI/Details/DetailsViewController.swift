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
        
        // Setup buttons.
        detailsView.startButton.addTarget(self, action: #selector(startRun), for: .touchUpInside)
        detailsView.finishButton.addTarget(self, action: #selector(finishRun), for: .touchUpInside)
        
        // Get run.
        RunTasticAPI.getRun(with: runId).start() { (response: HTTPResponse<Run>) in
            
            if let run = response.value {
            
                // Get run start time.
                if let startTime = run.startTime {
                    self.detailsView.startTimeLabel.text = "\(startTime)"
                } else {
                    self.detailsView.startTimeLabel.text = "N/A"
                    self.detailsView.startButton.isHidden = false
                }
                
                // Get run end time.
                if let endTime = run.endTime {
                    self.detailsView.endTimeLabel.text = "\(endTime)"
                } else {
                    self.detailsView.endTimeLabel.text = "N/A"
                    self.detailsView.finishButton.isHidden = !self.detailsView.startButton.isHidden
                }
                
                // Get run distance.
                if let distance = run.distance {
                    self.detailsView.distanceLabel.text = "\(distance)"
                } else {
                    self.detailsView.distanceLabel.text = "N/A"
                }
                
            } else {
                // TODO run not found!
            }
        }
    }
    
    @objc
    func startRun(_ sender: UIButton) {
        
        // Update buttons.
        detailsView.startButton.isHidden = true
        detailsView.finishButton.isHidden = false
        
        // Start run.
        RunTasticAPI.startRun(with: runId,
                              startTime: Date.millisecondsSinceEpoch)
            .start() { (response: HTTPEmptyResponse) in
                print("RUN STARTED!: \(response.result)")
            }
    }
    
    @objc
    func finishRun(_ sender: UIButton) {
        
        // Update buttons.
        detailsView.finishButton.isHidden = true
        
        // Finish run.
        RunTasticAPI.finishRun(with: runId,
                               endTime: Date.millisecondsSinceEpoch)
            .start() { (response: HTTPEmptyResponse) in
                print("RUN FINISHED!: \(response.result)")
            }
    }
}
