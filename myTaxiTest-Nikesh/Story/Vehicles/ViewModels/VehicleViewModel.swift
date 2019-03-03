//
//  VehicleViewModel.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation
import CoreLocation

typealias responseBlock = (_ result:Any?, _ error: Error?) -> ()

protocol VehiclesListViewDelegate: class {
    func didFetchDataSuccessfully()
    func didFailFetchingData(error: Error?)
}

class VehicleViewModel: NSObject {
    
    internal var vehicles: [Vehicle] = [Vehicle]()
    var manager = VehiclesManager()
    weak var viewDelegate: VehiclesListViewDelegate?
    
    var count: Int {
        return vehicles.count
    }
    
    func itemAtIndex(_ index: Int) -> Vehicle {
        return vehicles[index]
    }
    
    func get_id(at index: Int) -> Int? {
        return vehicles[index].id
    }
    
    func get_fleetType(at index: Int) -> FleetType? {
        return vehicles[index].fleetType
    }
    
    func get_numberOfSeats(at index: Int) -> Int? {
        return vehicles[index].numberOfSeats
    }
    
    func get_latitude(at index: Int) -> Double? {
        return vehicles[index].coordinates?.latitude
    }
    
    func get_longitude(at index: Int) -> Double? {
        return vehicles[index].coordinates?.longitude
    }
    
    func get_coordinates(at index: Int) -> LocationValue? {
        return vehicles[index].coordinates
    }
    
    func fetchAddressFromCoordinate(forModel model: Vehicle, completion: @escaping responseBlock) {
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: model.coordinates!.latitude!, longitude:model.coordinates!.longitude!)) { [weak self] (places, error) in
            if error == nil{
                if let place = places{
                    let data = (place.first?.thoroughfare ?? place.first?.administrativeArea ?? place.first?.locality, place.first?.country)
                    if data.0 != nil && data.1 != nil {
                        let model = self?.vehicles.first(where: {$0.id == model.id})
                        model?.addressString = "\(data.0!), \(data.1!)"
                        model?.isAddressDecoded = true
                    }
                    completion(data, nil)
                }
                completion(nil, nil)
            }
            completion(nil, error)
        }
    }

    
    @objc func fetchVehiclesInRegion(loc1: CLLocationCoordinate2D, loc2: CLLocationCoordinate2D) {
        let lat1 = Double(loc1.latitude)
        let long1 = Double(loc1.longitude)
        let lat2 = Double(loc2.latitude)
        let long2 = Double(loc2.longitude)
        manager.fetchVehiclesInRegion(lat1: lat1, long1: long1, lat2: lat2, long2: long2, completion: {
            [weak self] (data, error) in
            if let vehiclesList = data as? [Vehicle] {
                self?.vehicles = vehiclesList
                self?.viewDelegate?.didFetchDataSuccessfully()
            }
            else {
                self?.viewDelegate?.didFailFetchingData(error: error)
            }
            
        })
    }
}
