//
//  LocationStatisticsModel.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/2/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation

class LocationStatisticModel {
    var coordinate: CLLocationCoordinate2D?
    var imageLink: String?
    var totalRides: Int! = 0
    var pickupRank: Int! = 0
    var destinationRank: Int! = 0
    var totalRegisteredDrivers: Int! = 0
    var topDrivers: [Driver]?
}
