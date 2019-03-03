//
//  VechilesManager.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation
import Alamofire

class VehiclesManager {
    
    /// Requests server to send information of vehicles that are inside the specified geographical region
    ///
    /// - Parameters:
    ///   - lat1: first location latitude value
    ///   - long1: first location longitude value
    ///   - lat2: second location latitude value
    ///   - long2: second location longitude value
    ///   - completion: closure response that includes the responded data or error from the server
    func fetchVehiclesInRegion(lat1: Double, long1: Double, lat2: Double, long2: Double, completion: @escaping responseBlock) {
        let url = ApiLink.testLink.rawValue
        let parameters: [String: Any] = [VehicleListParameterKeys.pointOneLat.rawValue: lat1,
                                         VehicleListParameterKeys.pointTwoLat.rawValue: lat2,
                                         VehicleListParameterKeys.pointOneLong.rawValue: long1,
                                         VehicleListParameterKeys.pointTwoLong.rawValue: long2
                                         ]
        NetworkRequestManager().processApiRequest(urlLink: url, parameters: parameters, method: .get, headers: [:]) { (data, error) in
            if let err = error {
                completion(nil,err)
                return
            }
            else {
                if let jsonData = data as? [String: Any], let jsonDataArray = jsonData["poiList"] as? [[String: Any]] {
                    var vechilesList = [Vehicle]()
                    for dictData in jsonDataArray{
                        let vehicle = self.mapJSONDataToVehicleObject(dict: dictData)
                        if vehicle.isValid {
                            vechilesList.append(vehicle)
                        }
                    }
                    completion(vechilesList, nil)
                    return
                }
                else {
                    completion(nil, nil)
                    return
                }
            }
        }
    }
    
    
    /// Genenates and returns random value for number of seats in a vehicle
    ///
    /// - Returns: Integer value representing seats
    private func getDefaultNumberOfSeats() -> Int {
        let seats = [2, 3, 4, 6, 7, 8, 9]
        return seats.randomElement()!
    }
    
    
    /// Maps and converts JSON data into model object
    ///
    /// - Parameter dict: json data sent by the server
    /// - Returns: vehicle model object corresponding to json data
    private func mapJSONDataToVehicleObject(dict: [String: Any]) -> Vehicle {
        let vehicle = Vehicle()
        vehicle.id = dict[VehicleJSONKeys.id.rawValue] as? Int
        if let fleetTypeStr = dict[VehicleJSONKeys.fleetType.rawValue] as? String {
            vehicle.fleetType = FleetType(rawValue: fleetTypeStr)
        }
        vehicle.coordinates = LocationValue()
        if let coordinates = dict[VehicleJSONKeys.coordinate.rawValue] as? [String: Any] {
            vehicle.coordinates?.latitude = coordinates[VehicleJSONKeys.latitude.rawValue] as? Double ?? 0
            vehicle.coordinates?.longitude = coordinates[VehicleJSONKeys.longitude.rawValue] as? Double ?? 0
        }
        vehicle.heading = dict[VehicleJSONKeys.heading.rawValue] as? Double
        vehicle.numberOfSeats = dict[VehicleJSONKeys.numberOfSeats.rawValue] as? Int ?? getDefaultNumberOfSeats()
        
        let taxiImages = ["https://images.all-free-download.com/images/graphicthumb/taxi_design_vector_531133.jpg",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkBHsbIbFNxQiiXC1uEIxzbQzBVC_UT1yB6cJV8NU6WiQI1rrivg",
                          "https://cdn3.vectorstock.com/i/1000x1000/65/22/taxi-car-flat-design-vector-22666522.jpg",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq-CvHpEshfTpegkhNHnsjbrso8D6Q5xJ5Koa5hMqCuCTA0grghQ",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSRqPqWaP-vHP1BvQGMhZ3oVPqDWa7WbhGqNXxernAKRvkQgZ0hA"
        ]
        let taxiNames = ["Nissan Micra", "Maruti Suzuki Dzire", "Hyundai Xcent", "Toyota Platinum Etios", "Maruti Suzuki Ciaz", "Mahindra Scorpio", "Renault Lodgy"]
        vehicle.imageLink = taxiImages.randomElement()
        vehicle.name = taxiNames.randomElement()
        return vehicle
    }
    
}
