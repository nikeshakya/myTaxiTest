//
//  VehiclesDashboardViewController.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import UIKit
import CoreLocation
import JGProgressHUD

class VehiclesDashboardViewController: UIViewController {

    @IBOutlet weak var vehiclesListTableView: UITableView!
    
    let viewModel = VehicleViewModel()
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDelegate = self
        fetchData()
    }

    private func fetchData() {
        let loc1 = CLLocationCoordinate2D(latitude: 53.694865, longitude: 9.757589)
        let loc2 = CLLocationCoordinate2D(latitude: 53.394655, longitude: 10.099891)
        viewModel.fetchVehiclesInRegion(loc1: loc1, loc2: loc2)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        hud.show(in: self.view)
    }

}

extension VehiclesDashboardViewController: VehiclesListViewDelegate {
    func didFetchDataSuccessfully() {
        self.vehiclesListTableView.reloadData()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        hud.dismiss(animated: true)
    }
    
    func didFailFetchingData(error: Error?) {
        debugPrint("Error Fetching Vehicles list from server: \(error?.localizedDescription ?? "Invalid Data")")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        hud.dismiss(animated: true)
        self.showAlert(title: "Error", message: "There was an error fetching data.\nPlease Check your internet connection.")
    }
}

extension VehiclesDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionVehicleCell") as! RegionVehicleTableViewCell
        cell.configure(with: viewModel.itemAtIndex(indexPath.row))
        self.viewModel.fetchAddressFromCoordinate(forModel: viewModel.itemAtIndex(indexPath.row)) { (data, error) in
            if let address = data as? (String?, String?) {
                cell.updateAddress(withData: address)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120).relativeToIphone8Width()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vehicleModel = viewModel.itemAtIndex(indexPath.row)
        let driverModel = MapViewViewModel.getDriverInfo()
        let detailsViewModel = DriverDetailsViewModel(taxiModel: vehicleModel, driverModel: driverModel)
        let detailsVC = UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "vehicleDetailsVC") as! VehicleDetailsViewController
        detailsVC.viewModel = detailsViewModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

