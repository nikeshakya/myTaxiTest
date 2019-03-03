//
//  LocationStatisticsViewModel.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/2/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

@objc class LocationStatisticsViewModel: NSObject {
    var model: LocationStatisticModel!
    var locationName: String?
    var countryName: String?
    
    var driverOneImageLink: String {
        return model.topDrivers![0].profilePicture ?? ""
    }
    
    var driverTwoImageLink: String {
        return model.topDrivers![1].profilePicture ?? ""
    }
    
    var driverThreeImageLink: String {
        return model.topDrivers![2].profilePicture ?? ""
    }
    
    var imageLink: String {
        return model.imageLink ?? ""
    }
    
    var totalRidesString: String {
        return "Total rides completed: \(model.totalRides ?? 0)"
    }
    
    var pickupRankString: String {
        return "Pickup rank: \(model.pickupRank ?? 0)"
    }
    
    var destinationRankString: String {
        return "Destination rank: \(model.destinationRank ?? 0)"
    }
    
    var registeredDriversString: String {
        return "Destination rank: \(model.totalRegisteredDrivers ?? 0)"
    }
    
    init(model: LocationStatisticModel, city: String, country: String) {
        super.init()
        self.model = model
        self.locationName = city
        self.countryName = country
        self.fillWithDummyData()
    }
    
    private func fetchAddressFromCoordinate() {
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: model.coordinate!.latitude, longitude:model.coordinate!.longitude)) { [weak self] (places, error) in
            if error == nil{
                if let place = places{
                    self?.locationName = place.first?.locality
                    self?.countryName = place.first?.country
                }
            }
        }
    }
    
    private func fillWithDummyData() {
        let cityImageLinks = ["https://images.unsplash.com/photo-1428976307195-3095182068f7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60",
                              "https://images.unsplash.com/photo-1532701908539-968e2a55245e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60",
                              "https://images.unsplash.com/photo-1532193748395-3e3ee2020605?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60",
                              "https://images.unsplash.com/photo-1550837725-56d9e2f0d89b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60",
                              "https://images.unsplash.com/photo-1545044846-351ba102b6d5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60",
                              "https://images.unsplash.com/photo-1543829285-3606cff6d1e5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60"
        ]
        
        let pickupRank = Int.random(in: 1...100)
        let destinationRank = Int.random(in: 1...100)
        let totalRides = Int.random(in: 200...2500)
        let totalDrivers = Int.random(in: 100...1500)
        
        model.imageLink = cityImageLinks.randomElement()
        model.pickupRank = pickupRank
        model.destinationRank = destinationRank
        model.totalRides = totalRides
        model.totalRegisteredDrivers = totalDrivers
        model.topDrivers = getTopDrivers()
    }
    
    private func getTopDrivers() -> [Driver] {
        var driverInfo = ["Karl Drag": "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "William Hamming": "https://images.pexels.com/photos/555790/pexels-photo-555790.png?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "Simon Barb": "https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "Bobbie Mendal": "https://images.pexels.com/photos/1300402/pexels-photo-1300402.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "Carlos Chan": "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
        ]
        let driver1 = Driver()
        let driver1info = driverInfo.randomElement()!
        driverInfo.removeValue(forKey: driver1info.key)
        driver1.age = 25
        driver1.fullName = driver1info.key
        driver1.gender = .male
        driver1.id = 1
        driver1.rating = Rating.random()
        driver1.profilePicture = driver1info.value
        driver1.taxiId = 1
        driver1.statusMessage = DriverStatusMessage.random()
        
        let driver2 = Driver()
        let driver2info = driverInfo.randomElement()!
        driverInfo.removeValue(forKey: driver2info.key)
        driver2.age = 30
        driver2.fullName = driver2info.key
        driver2.gender = .male
        driver2.id = 2
        driver2.rating = Rating.random()
        driver2.profilePicture = driver2info.value
        driver2.taxiId = 2
        driver2.statusMessage = DriverStatusMessage.random()
        
        let driver3 = Driver()
        let driver3info = driverInfo.randomElement()!
        driverInfo.removeValue(forKey: driver3info.key)
        driver3.age = 28
        driver3.fullName = driver3info.key
        driver3.gender = .male
        driver3.id = 4
        driver3.rating = Rating.random()
        driver3.profilePicture = driver3info.value
        driver3.taxiId = 500
        driver3.statusMessage = DriverStatusMessage.random()
        
        return [driver1, driver2, driver3]
    }
}
