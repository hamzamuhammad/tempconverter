//
//  Location.swift
//  WorldTrotter
//
//  Created by Hamza Muhammad on 7/29/16.
//  Copyright © 2016 Hamza Muhammad. All rights reserved.
//

import UIKit
import MapKit

class Location: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
