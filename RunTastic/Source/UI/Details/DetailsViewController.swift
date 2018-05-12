//
//  DetailsViewController.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/12/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import MapKit
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
        
        // Setup map view.
        detailsView.mapView.delegate = self
        
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
        
        // Get route.
        RunTasticAPI.getRunRoute(with: runId).start() { (response: HTTPResponse<[Location]>) in
            
            if let locations = response.value, locations.count >= 2 {
                
                // Get coordinates and create route line.
                let coordinates = locations.map({ $0.coordinate })
                let routeLine = MKPolyline(coordinates: coordinates, count: coordinates.count)
                
                // Set the visible region of the map to contain the route.
                self.detailsView.mapView.setVisibleMapRect(routeLine.boundingMapRect,
                                                           edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: false)
                self.detailsView.mapView.add(routeLine)
                
                // Add the start point.
                if let startCoordinate = coordinates.first {
                    let startAnnotation = MKPointAnnotation()
                    startAnnotation.coordinate = startCoordinate
                    startAnnotation.title = "Start"
                    self.detailsView.mapView.addAnnotation(startAnnotation)
                }
                
                // Add the finish point.
                if let finishCoordinate = coordinates.last {
                    let finishAnnotation = MKPointAnnotation()
                    finishAnnotation.coordinate = finishCoordinate
                    finishAnnotation.title = "Finish"
                    self.detailsView.mapView.addAnnotation(finishAnnotation)
                }
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

extension DetailsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        // TODO
        // Handle multiple overlays.
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5
        renderer.strokeColor = UIColor.black.withAlphaComponent(0.5)
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKMarkerAnnotationView
        
        if view == nil {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            
            if annotation.title == "Start" {
                view?.markerTintColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
            } else if annotation.title == "Finish" {
                view?.markerTintColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
            }
        }
        
        return view
    }
}
