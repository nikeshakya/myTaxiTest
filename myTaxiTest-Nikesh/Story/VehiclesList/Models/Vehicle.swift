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
    
    override init() {
        super.init()
    }
    
    init(lat: Double, lon: Double) {
        self.latitude = lat
        self.longitude = lon
    }
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

extension Vehicle {
    public static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.fleetType == rhs.fleetType && lhs.coordinates == rhs.coordinates && lhs.heading == rhs.heading && lhs.numberOfSeats == rhs.numberOfSeats
    }
}
