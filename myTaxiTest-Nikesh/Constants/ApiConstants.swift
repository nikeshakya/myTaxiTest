//
//  ApiConstants.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation

enum ApiLink: String{
    case testLink = "https://fake-poi-api.mytaxi.com"
}

enum VehicleListParameterKeys: String {
    case pointOneLat = "p1Lat"
    case pointOneLong = "p1Lon"
    case pointTwoLat = "p2Lat"
    case pointTwoLong = "p2Lon"
}

enum VehicleJSONKeys: String {
    case id = "id"
    case coordinate = "coordinate"
    case fleetType = "fleetType"
    case heading = "heading"
    case latitude = "latitude"
    case longitude = "longitude"
    case numberOfSeats = "seats"
}
