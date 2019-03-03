//
//  DriverDetailsViewModel.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/3/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation

@objc class DriverDetailsViewModel: NSObject {
    var driverModel: Driver!
    var taxiModel: Vehicle!
    
    init(taxiModel: Vehicle, driverModel: Driver!) {
        super.init()
        self.driverModel = driverModel
        self.taxiModel = taxiModel
    }
    
    func getDriversFullName() -> String{
        return driverModel.fullName ?? "Test Driver"
    }
    
    func getDriverImageString() -> String{
        return driverModel.profilePicture ?? ""
    }
    
    func getTaxiName() -> String {
        return taxiModel.name ?? "Taxi Nikesh"
    }
    
    func getTaxiImageLink() -> String {
        return taxiModel.imageLink ?? ""
    }
    
    func getDriverMessage() -> String {
        return driverModel.statusMessage.rawValue
    }
    
    func getTaxiSeatNumberString() -> String {
        return "Seats: \(taxiModel.numberOfSeats ?? 2)"
    }
    
    func getFleetTypeTextColor() -> UIColor {
        return (taxiModel.fleetType == .carpooling) ? UIColor(named: "poolingFontColor")! : UIColor(named: "taxiFontColor")!
    }
    
    func getFleetTypeString() -> String {
        return taxiModel.fleetType == .carpooling ? "Type: Carpooling" : "Type: Taxi"
    }
    
    func getDriverAgeString() -> String{
        return "Age: \(driverModel.age ?? 25)"
    }
    
    func getDriverGenderString() -> String {
        return driverModel.gender == .female ? "Gender: F" : "Gender: M"
    }
    
    func getDriverRating() -> Int {
        return driverModel.rating!.rawValue
    }
}
