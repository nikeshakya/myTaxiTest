//
//  Marker.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/2/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Marker {
    var type: FleetType?
    var id: Int?
    var title: String?
    var coordinate: CLLocationCoordinate2D?
    var heading: Double?
    var annotation: VehicleAnnotation?
    var isValid: Bool {
        return id != nil && coordinate != nil && type != nil && heading != nil
    }
    var isValidWithAnnotation: Bool {
        return isValid && annotation != nil
    }
}
