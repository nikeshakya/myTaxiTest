//
//  MapViewModel.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/2/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

@objc protocol MapMarkersUpdateDelegate: class {
    func didFetchMarkersDataSuccessfully()
    func didFailFetchingMarkersData(error: Error?)
    func clearMapViewMarkers(markers: [MKAnnotation])
}

@objc class MapViewViewModel: NSObject, VehiclesListViewDelegate{
    var vehicleViewModel = VehicleViewModel()
    var markers = [Marker]()
    @objc weak var vehicleMarkersDelegate: MapMarkersUpdateDelegate?
    
    var annotations: [MKAnnotation] {
        return markers.count > 0 ? markers.map({$0.annotation!}) : []
    }
    
    override init() {
        super.init()
        vehicleViewModel.viewDelegate = self
    }
    
    @objc func fetchVehiclesInRegion(loc1: CLLocationCoordinate2D, loc2: CLLocationCoordinate2D) {
        vehicleViewModel.fetchVehiclesInRegion(loc1: loc1, loc2: loc2)
    }
    
    func didFetchDataSuccessfully() {
        flushMapData()
        for vehicle in vehicleViewModel.vehicles {
            let marker = Marker()
            marker.id = vehicle.id
            marker.type = vehicle.fleetType
            marker.coordinate = CLLocationCoordinate2D(latitude: vehicle.coordinates!.latitude!, longitude: vehicle.coordinates!.longitude!)
            marker.title = vehicle.fleetType?.rawValue
            marker.heading = vehicle.heading
            if marker.isValid {
                marker.annotation = self.generateMarker(withData: marker)
                if marker.isValidWithAnnotation {
                    markers.append(marker)
                }
            }
        }
        vehicleMarkersDelegate?.didFetchMarkersDataSuccessfully()
    }
    
    func didFailFetchingData(error: Error?) {
        debugPrint("Couldn't load data")
        flushMapData()
        vehicleMarkersDelegate?.didFailFetchingMarkersData(error: error)
    }
    
    private func flushMapData() {
        vehicleMarkersDelegate?.clearMapViewMarkers(markers: annotations)
        markers.removeAll()
    }
    
    @objc func updateMapWithBoundMarkers(map: MKMapView) {
        for marker in markers {
            addMarkerToMapView(mapView: map, marker: marker.annotation!)
        }
    }
    
    @objc func didTapAnnotation(annotation: MKAnnotation) -> DriverDetailsViewModel?{
        if let vehicleModel = vehicleViewModel.vehicles.first(where: {$0.coordinates?.latitude == annotation.coordinate.latitude && $0.coordinates?.longitude == annotation.coordinate.longitude}) {
            let driver = MapViewViewModel.getDriverInfo()
            let detailsViewModel = DriverDetailsViewModel(taxiModel: vehicleModel, driverModel: driver)
            return detailsViewModel
            
        }
        return nil
    }
    
    static func getDriverInfo() -> Driver {
        let driverDict = ["Karl Drag": "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "William Hamming": "https://images.pexels.com/photos/555790/pexels-photo-555790.png?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "Simon Barb": "https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "Bobbie Mendal": "https://images.pexels.com/photos/1300402/pexels-photo-1300402.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "Carlos Chan": "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
        ]
        let driverInfo = Driver()
        let driverRand = driverDict.randomElement()!
        driverInfo.age = 25
        driverInfo.fullName = driverRand.key
        driverInfo.gender = Gender.male
        driverInfo.id = 1
        driverInfo.rating = Rating.random()
        driverInfo.profilePicture = driverRand.value
        driverInfo.taxiId = 1
        driverInfo.statusMessage = DriverStatusMessage.random()
        return driverInfo
    }
    
    private func addMarkerToMapView(mapView: MKMapView, marker: VehicleAnnotation) {
        mapView.addAnnotation(marker)
    }
    
    private func generateMarker(withData markerData: Marker) -> VehicleAnnotation {
        let marker = VehicleAnnotation()
        marker.coordinate = markerData.coordinate!
        if markerData.type! == .taxi {
            marker.markerImageName = "taxi-marker"
        }
        else {
            marker.markerImageName = "pool-marker"
        }
        marker.heading = markerData.heading!
        return marker
    }
    
    
}
