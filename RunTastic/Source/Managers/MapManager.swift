//
//  MapManager.swift
//  RunTastic
//
//  Created by Ryan Crist on 5/28/18.
//  Copyright © 2018 Shrubtactic. All rights reserved.
//

import Foundation
import MapKit

class MapManager: NSObject {
    
    // MARK: - Public Properties
    
    weak var mapView: MKMapView? {
        didSet {
            mapView?.delegate = self
        }
    }
    
    // MARK: - Public Methods
    
    func addRouteToMap(_ locations: [CLLocation]) {
        addRouteToMap(locations.map({ LocationDTO($0) }))
    }
    
    func addRouteToMap(_ locations: [LocationDTO]) {
        
        // Abort if there is no map view to update.
        guard let mapView = mapView else { return }
        
        // Abort if there are less than 2 locations in the route.
        guard locations.count >= 2 else { return }
        
        // Get coordinates and create route line.
        let coordinates = locations.map({ $0.coordinate })
        let routeLine = MKPolyline(coordinates: coordinates, count: coordinates.count)
        
        // Set the visible region of the map to contain the route.
        mapView.setVisibleMapRect(routeLine.boundingMapRect,
                                  edgePadding: UIEdgeInsets(top: 25,
                                                            left: 25,
                                                            bottom: 25,
                                                            right: 25),
                                  animated: false)
        mapView.add(routeLine)
        
        // Add the start point.
        if let startCoordinate = coordinates.first {
            let startAnnotation = MKPointAnnotation()
            startAnnotation.coordinate = startCoordinate
            startAnnotation.title = "Start"
            mapView.addAnnotation(startAnnotation)
        }
        
        // Add the finish point.
        if let finishCoordinate = coordinates.last {
            let finishAnnotation = MKPointAnnotation()
            finishAnnotation.coordinate = finishCoordinate
            finishAnnotation.title = "Finish"
            mapView.addAnnotation(finishAnnotation)
        }
    }
}

extension MapManager: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        // TODO
        // Handle multiple overlays.
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5
        renderer.strokeColor = UIColor.primary?.withAlphaComponent(0.8)
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // TODO find more appropriate way to prevent overriding the user annotation.
        guard !(annotation is MKUserLocation) else { return nil }
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKMarkerAnnotationView
        
        if view == nil {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            
            if annotation.title == "Start" {
                view?.markerTintColor = .start
            } else if annotation.title == "Finish" {
                view?.markerTintColor = .finish
            }
        }
        
        return view
    }
}
