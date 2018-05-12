//
//  MapViewController.swift
//  RacYa
//
//  Created by Ryan Crist on 4/22/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import CoreLocation
import UIKit

class MapViewController: UIViewController {
    
    lazy var mapView = MapView()
    
    var runId: Int?
    
    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO
        LocationManager.shared.delegate = self
        
        // Add button listeners.
        mapView.startStopButton.addTarget(self, action: #selector(startStopButtonPressed), for: .touchUpInside)
    }
    
    @objc
    func startStopButtonPressed(_ sender: UIButton) {
        
        if let runId = runId {
            
//            HTTPClient.client()
//                .request(method: .post,
//                         path: "run/finish",
//                         headers: ["Content-Type": "application/json"],
//                         with: HTTPRequestEncoders.json,
//                         data: Run.Finish.Request(id: runId,
//                                                  timestamp: Date.millisecondsSinceEpoch))
//                .start(with: HTTPResponseDecoders.empty) { (response: HTTPResponse<Void>) in
//                    
//                    // Reset run ID.
//                    self.runId = nil
//                    
//                    // Style start/stop button.
//                    sender.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
//                    sender.setTitle("START", for: .normal)
//                }
            
        } else {
            
//            HTTPClient.client()
//                .request(method: .post,
//                         path: "run/start",
//                         headers: ["Content-Type": "application/json"],
//                         with: HTTPRequestEncoders.json,
//                         data: Run.Start.Request(timestamp: Date.millisecondsSinceEpoch))
//                .start(with: HTTPResponseDecoders.number) { (response: HTTPResponse<Int>) in
//
//                    // Save run ID.
//                    self.runId = response.value
//
//                    // Style start/stop button.
//                    sender.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
//                    sender.setTitle("STOP", for: .normal)
//                }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("LOCATION UPDATE = \(locations)")
    }
}

