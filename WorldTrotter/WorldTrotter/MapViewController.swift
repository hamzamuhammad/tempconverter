//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Hamza Muhammad on 7/29/16.
//  Copyright © 2016 Hamza Muhammad. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite", "My Location"])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), forControlEvents:  .ValueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        let leadingConstrant = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)

        topConstraint.active = true
        leadingConstrant.active = true
        trailingConstraint.active = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
            mapTypeChangedResetView()
        case 1:
            mapView.mapType = .Hybrid
            mapTypeChangedResetView()
        case 2:
            mapView.mapType = .Satellite
            mapTypeChangedResetView()
        case 3:
            locationManager = CLLocationManager()
            locationManager.requestAlwaysAuthorization()
            mapView.showsUserLocation = true
            mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
        default:
            break
        }
    }
    
    func mapViewWillStartLocatingUser(mapView: MKMapView) {
        print("Tracking user location...")
    }
    
    func showUserLocation(sender: AnyObject) {
        mapView.showsUserLocation = true
    }
    
    func mapTypeChangedResetView() {
        mapView.showsUserLocation = false
        mapView.region = MKCoordinateRegionForMapRect(MKMapRectWorld)
    }
}