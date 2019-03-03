//
//  MapBottomStatView.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/2/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import UIKit
import Kingfisher

class MapBottomStatView: UIView {
    // MARK:- Outle Properties and class variables
    @IBOutlet weak var topDriverPicViewThree: UIImageView!
    @IBOutlet weak var topDriverPicViewTwo: UIImageView!
    @IBOutlet weak var topDriverPicViewOne: UIImageView!
    @IBOutlet weak var registeredDriversLabel: UILabel!
    @IBOutlet weak var destinationRankLabel: UILabel!
    @IBOutlet weak var pickupRankLabel: UILabel!
    @IBOutlet weak var totalRidesLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!

    var viewModel: LocationStatisticsViewModel!
    
    // MARK:- Life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK:- View UI update methods
    
    /// Updates View Elements data with model object data
    ///
    /// - Parameters:
    ///   - coordinate: Location value of center map point
    ///   - city: Corresponding city representation of coordinate
    ///   - country: Corresponding country representation of coordinate
    ///   - animated: Boolean representing whether update should be shown with animation
    @objc func updateViewWithAddress(coordinate: CLLocationCoordinate2D, city: String, country: String, animated: Bool = true) {
        self.alpha = 0
        self.isHidden = false
        let model = LocationStatisticModel()
        model.coordinate = coordinate
        viewModel = LocationStatisticsViewModel(model: model, city: city, country: country)
        
        cityLabel.text = viewModel.locationName ?? "Test Address"
        countryLabel.text = viewModel.countryName ?? "Test Country"
        totalRidesLabel.text = viewModel.totalRidesString
        pickupRankLabel.text = viewModel.pickupRankString
        destinationRankLabel.text = viewModel.destinationRankString
        registeredDriversLabel.text = viewModel.registeredDriversString
        placeImageView.kf.setImage(with: URL(string: viewModel.imageLink), placeholder: nil, options: nil, progressBlock: nil) { (result) in
            switch result {
            case .failure(let error):
                debugPrint("Error loading image: \(error.localizedDescription)")
            case .success(let data):
                debugPrint("Image loaded from \(data.source.cacheKey)")
            }
        }
        
        topDriverPicViewOne.kf.setImage(with: URL(string: viewModel.driverOneImageLink), placeholder: nil, options: nil, progressBlock: nil) { (result) in
            switch result {
            case .failure(let error):
                debugPrint("Error loading image: \(error.localizedDescription)")
            case .success(let data):
                debugPrint("Image loaded from \(data.source.cacheKey)")
            }
        }
        
        topDriverPicViewTwo.kf.setImage(with: URL(string: viewModel.driverTwoImageLink), placeholder: nil, options: nil, progressBlock: nil) { (result) in
            switch result {
            case .failure(let error):
                debugPrint("Error loading image: \(error.localizedDescription)")
            case .success(let data):
                debugPrint("Image loaded from \(data.source.cacheKey)")
            }
        }
        
        topDriverPicViewThree.kf.setImage(with: URL(string: viewModel.driverThreeImageLink), placeholder: nil, options: nil, progressBlock: nil) { (result) in
            switch result {
            case .failure(let error):
                debugPrint("Error loading image: \(error.localizedDescription)")
            case .success(let data):
                debugPrint("Image loaded from \(data.source.cacheKey)")
            }
        }
        
        guard animated else {
            self.alpha = 1
            return
        }
        UIView.animate(withDuration: 0.4) {
            [weak self] in
            self?.alpha = 1
        }
    }
}
