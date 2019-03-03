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

/// Communication protocol from view model to map view
@objc protocol MapMarkersUpdateDelegate: class {
    /// Notifies the view about successful fetching of map data
    func didFetchMarkersDataSuccessfully()
    
    /// Notifies view about the error occurred during the process of fetching map data
    ///
    /// - Parameter error: Error value corresponding to the cause of unsuccessful result
    func didFailFetchingMarkersData(error: Error?)
    
    /// Deletes all the annotation data from the map in specific view
    ///
    /// - Parameter markers: an array of annotation data that are currently displayed in map
    func clearMapViewMarkers(markers: [MKAnnotation])
}

@objc class MapViewViewModel: NSObject{
    // MARK:- Variables
    var vehicleViewModel = VehiclesListViewModel()
    var markers = [Marker]()
    @objc weak var vehicleMarkersDelegate: MapMarkersUpdateDelegate?
    
    var annotations: [MKAnnotation] {
        return markers.count > 0 ? markers.map({$0.annotation!}) : []
    }
    
    // MARK:- Life cycle methods
    override init() {
        super.init()
        vehicleViewModel.viewDelegate = self
    }
    
    init(markers: [Marker]) {
        super.init()
        self.markers = markers
        vehicleViewModel.viewDelegate = self
    }
    
    // MARK:- Auto Fill Assistant Methods
    
    /// Generates and returns random driver full detailed information
    ///
    /// - Returns: driver object generated
    static func getDriverInfo() -> Driver {
        let driverDict = ["Karl Drag": "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "William Hamming": "https://images.pexels.com/photos/555790/pexels-photo-555790.png?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "Simon Barb": "https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "Bobbie Mendal": "https://images.pexels.com/photos/1300402/pexels-photo-1300402.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                          "Carlos Chan": "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
        ]
        let driverInfo = Driver()
        let driverRand = driverDict.randomElement()!
        driverInfo.age = Int.random(in: 25...38)
        driverInfo.fullName = driverRand.key
        driverInfo.gender = Gender.male
        driverInfo.id = 1
        driverInfo.rating = Rating.random()
        driverInfo.profilePicture = driverRand.value
        driverInfo.taxiId = 1
        driverInfo.statusMessage = DriverStatusMessage.random()
        return driverInfo
    }
    
    // MARK:- Coordinator and Data Control Methods
    
    /// Requests network service coordinator to send vehicle information in give region
    ///
    /// - Parameters:
    ///   - loc1: first location value
    ///   - loc2: second location value
    @objc func fetchVehiclesInRegion(loc1: CLLocationCoordinate2D, loc2: CLLocationCoordinate2D) {
        vehicleViewModel.fetchVehiclesInRegion(loc1: loc1, loc2: loc2)
    }
    
    /// Clears map view by removing all markers
    private func flushMapData() {
        vehicleMarkersDelegate?.clearMapViewMarkers(markers: annotations)
        markers.removeAll()
    }
    
    /// Generates custom marker object to be displayed in the app with respect to vehicle data
    ///
    /// - Parameter markerData: marker object containing location and vehicle information
    /// - Returns: annotaion object containing map location and marker data
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
    
    private func addMarkerToMapView(mapView: MKMapView, marker: VehicleAnnotation) {
        mapView.addAnnotation(marker)
    }
    
    /// Adds markers/annotations to the map
    ///
    /// - Parameter map: Map view that requires updating with markers
    @objc func updateMapWithBoundMarkers(map: MKMapView) {
        for marker in markers {
            addMarkerToMapView(mapView: map, marker: marker.annotation!)
        }
    }
    
    /// Retrieves corresponding driver and vehicle details on tapping marker in map view
    ///
    /// - Parameter annotation: annotation or location data residing in tap point
    /// - Returns: view model object containing both driver and vehicle information
    @objc func didTapAnnotation(annotation: MKAnnotation) -> DriverDetailsViewModel?{
        if let vehicleModel = vehicleViewModel.vehicles.first(where: {$0.coordinates?.latitude == annotation.coordinate.latitude && $0.coordinates?.longitude == annotation.coordinate.longitude}) {
            let driver = MapViewViewModel.getDriverInfo()
            let detailsViewModel = DriverDetailsViewModel(taxiModel: vehicleModel, driverModel: driver)
            return detailsViewModel
            
        }
        return nil
    }
    
}

extension MapViewViewModel: VehiclesListViewDelegate {
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
}
