//
//  RegionVehicleTableViewCell.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import UIKit

class RegionVehicleTableViewCell: UITableViewCell {

    @IBOutlet weak var taxiNameLabel: UILabel!
    @IBOutlet weak var taxiTypeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    @IBOutlet weak var vehicleImageView: UIImageView!
    
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
    
    func updateAddress(withData data: (String?, String?)) {
        locationLabel.text = "\(data.0 ?? "TestAddress"), \(data.1 ?? "TestCountry")"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
