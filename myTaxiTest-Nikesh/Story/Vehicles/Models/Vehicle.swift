//
//  Vehicle.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation

enum FleetType: String {
    case carpooling = "POOLING"
    case taxi = "TAXI"
}

@objc class LocationValue: NSObject {
    var longitude: Double?
    var latitude: Double?
}

@objc class Vehicle: NSObject {
    var id: Int?
    var name: String?
    var fleetType: FleetType?
    var coordinates: LocationValue?
    var imageLink: String?
    var heading: Double?
    var numberOfSeats: Int?
    var addressString: String?
    var isAddressDecoded = false
    var isValid: Bool {
        return id != nil
    }
}

