//
//  MKMapView.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/2/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension MKMapView {
    
    /// Retrieves and returns the visible rect edge coordinates in the map
    ///
    /// - Returns: Boundary Point object represntation of visible rect
    @objc func getVisibleBoundCoordinates() -> MapBoundCoordinates {
        let visibleRect = self.visibleMapRect
        let bottomLeft = MKMapPoint(x: visibleRect.origin.x, y: visibleRect.maxY)
        let topRight = MKMapPoint(x: visibleRect.maxX, y: visibleRect.origin.y)
        let boundCoordinates = MapBoundCoordinates()
        boundCoordinates.pointOne = bottomLeft.coordinate
        boundCoordinates.pointTwo = topRight.coordinate
        return boundCoordinates
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
}
