//
//  RegionVehicleTableViewCell.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import UIKit

class RegionVehicleTableViewCell: UITableViewCell {
    // MARK:- Outlet Properties
    @IBOutlet weak var taxiNameLabel: UILabel!
    @IBOutlet weak var taxiTypeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    @IBOutlet weak var vehicleImageView: UIImageView!
    
    // MARK:- Life cycle and Configuration Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Initializes Cell components with the given model object data
    ///
    /// - Parameter vehicle: vehicle object data containg view information
    func configure(with vehicle: Vehicle) {
        taxiNameLabel.text = vehicle.name ?? "Car - \(vehicle.id ?? 0)"
        seatsLabel.text = "\(vehicle.numberOfSeats!) seats"
        if vehicle.isAddressDecoded {
            locationLabel.text = vehicle.addressString
        }
        else {
            locationLabel.text = "Lon: \(vehicle.coordinates!.longitude!), Lat: \(vehicle.coordinates!.latitude!)"
        }
        switch vehicle.fleetType! {
        case .carpooling:
            taxiTypeLabel.text = FleetType.carpooling.rawValue
            taxiTypeLabel.textColor = UIColor(named: "poolingFontColor")
        default:
            taxiTypeLabel.text = FleetType.taxi.rawValue
            taxiTypeLabel.textColor = UIColor(named: "taxiFontColor")
        }
        vehicleImageView.kf.setImage(with: URL(string: vehicle.imageLink ?? ""), placeholder: nil, options: nil, progressBlock: nil) { (result) in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
    
    /// Updates corresponding view element with retrieved address data
    ///
    /// - Parameter data: Address information in String tuple format (city, country)
    func updateAddress(withData data: (String?, String?)) {
        locationLabel.text = "\(data.0 ?? "TestAddress"), \(data.1 ?? "TestCountry")"
    }
}
