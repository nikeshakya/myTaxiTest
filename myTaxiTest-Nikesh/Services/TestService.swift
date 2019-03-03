//
//  TestService.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/3/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation

class TestService {
    static func getTestVehicleObject() -> Vehicle{
        let vehicle = Vehicle()
        vehicle.id = 123
        vehicle.name = "Test BMW"
        vehicle.fleetType = .taxi
        vehicle.coordinates = LocationValue(lat: 22.76, lon: 45.345)
        vehicle.heading = 54.345
        vehicle.numberOfSeats = 5
        return vehicle
    }
    
    static func getTestDriverObject() -> Driver {
        let driverInfo = Driver()
        driverInfo.age = 25
        driverInfo.fullName = "Nikesh Shakya"
        driverInfo.gender = Gender.male
        driverInfo.id = 1
        driverInfo.rating = Rating.random()
        driverInfo.taxiId = 1
        driverInfo.statusMessage = DriverStatusMessage.random()
        return driverInfo
    }
    
    static func getTestMarkerObject(withVehicle vehicle: Vehicle) -> Marker {
        let marker = Marker()
        marker.id = vehicle.id
        marker.type = vehicle.fleetType
        marker.coordinate = CLLocationCoordinate2D(latitude: vehicle.coordinates!.latitude!, longitude: vehicle.coordinates!.longitude!)
        marker.title = vehicle.fleetType?.rawValue
        marker.heading = vehicle.heading
        let markerAnnotation = VehicleAnnotation()
        markerAnnotation.coordinate = marker.coordinate!
        markerAnnotation.heading = marker.heading!
        marker.annotation = markerAnnotation
        return marker
    }
    
    static func getTestLocationStatisticObject() -> LocationStatisticModel{
        let model = LocationStatisticModel()
        model.coordinate = CLLocationCoordinate2D(latitude: 23.2, longitude: 23.23)
        return model
    }
}
