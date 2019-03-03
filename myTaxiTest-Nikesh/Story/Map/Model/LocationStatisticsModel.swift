//
//  LocationStatisticsModel.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/2/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation

class LocationStatisticModel: Equatable {
    var coordinate: CLLocationCoordinate2D?
    var imageLink: String?
    var totalRides: Int! = 0
    var pickupRank: Int! = 0
    var destinationRank: Int! = 0
    var totalRegisteredDrivers: Int! = 0
    var topDrivers: [Driver]?
}

extension LocationStatisticModel {
    public static func == (lhs: LocationStatisticModel, rhs: LocationStatisticModel) -> Bool {
        return lhs.coordinate == rhs.coordinate && lhs.totalRides == rhs.totalRides && lhs.pickupRank == rhs.pickupRank && lhs.destinationRank == rhs.destinationRank && lhs.totalRegisteredDrivers == rhs.totalRegisteredDrivers
    }
}
