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
    var birthPlace: Location!
    var currentHome: Location!
    var summerVacation: Location!
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let segmentedControl = UISegmentedControl(items: [standardString, satelliteString, hybridString, "My Location"])
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
        
        birthPlace = Location(title: "Islamabad", coordinate: CLLocationCoordinate2D(latitude: 33.729388, longitude: 73.093146), info: "Where I was born")
        currentHome = Location(title: "Austin", coordinate: CLLocationCoordinate2D(latitude: 30.267153,
            longitude: -97.743061), info: "Where I am living")
        summerVacation = Location(title: "Cancun", coordinate: CLLocationCoordinate2D(latitude: 21.161908,
            longitude: -86.851528), info: "Where I have been")
        
        mapView.addAnnotation(birthPlace)
        mapView.addAnnotation(currentHome)
        mapView.addAnnotation(summerVacation)
        
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