//
//  VehicleDetailsViewController.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/3/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import UIKit
import MapKit

class VehicleDetailsViewController: UIViewController {
    // MARK:- Outlet properties and Variables
    @IBOutlet weak var vehicleSeatNumberLabel: UILabel!
    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var vehicleMapView: MKMapView!
    @IBOutlet weak var driverDetailsView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var driverInfoView = DriverInfoView()
    var viewModel: DriverDetailsViewModel!
    
    // MARK:- Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    /// Initializes view UI components
    private func configureView() {
        driverInfoView.addToView(view: self.driverDetailsView)
        driverInfoView.refreshWithViewModel(model: viewModel)
        driverInfoView.closeBtn.isHidden = true
        driverInfoView.isHidden = false
        configureAndLoadMap()
        vehicleSeatNumberLabel.text = driverInfoView.numberOfSeats.text
        vehicleNameLabel.text = driverInfoView.taxiNameLabel.text
    }
    
    /// Initializes view map and sets specified region in the map
    private func configureAndLoadMap() {
        let center = CLLocationCoordinate2D(latitude: viewModel.taxiModel.coordinates!.latitude!, longitude: viewModel.taxiModel.coordinates!.longitude!)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        vehicleMapView.setRegion(region, animated: true)
        let annotation = VehicleAnnotation()
        annotation.coordinate = center
        vehicleMapView.addAnnotation(annotation)
    }
}
