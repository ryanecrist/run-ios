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
        
        title = "Run \(runId)"
    }
}
