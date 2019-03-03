//
//  DriverInfoView.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/3/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import UIKit
import Kingfisher

@objc class DriverInfoView: UIView {
    // MARK:- Outlet properties and action methods
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet var ratingImages: [UIImageView]!
    @IBOutlet weak var driverStatusMessageLabel: UILabel!
    @IBOutlet weak var driverGenderLabel: UILabel!
    @IBOutlet weak var driverAgeLabel: UILabel!
    @IBOutlet weak var driverFullNameLabel: UILabel!
    @IBOutlet weak var driverPicView: UIImageView!
    @IBOutlet weak var numberOfSeats: UILabel!
    @IBOutlet weak var taxiTypeLabel: UILabel!
    @IBOutlet weak var taxiImageView: UIImageView!
    @IBOutlet weak var taxiNameLabel: UILabel!
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        closeView()
    }
    
    // MARK:- Class variables
    var driverDetailsViewModel: DriverDetailsViewModel!
    
    // MARK:- Life cycle methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed("DriverInfoView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK:- View Data Coordination and UI update methods
    
    /// Re-iniitializes the view with provided view model data object
    ///
    /// - Parameter model: View Model object containing driver and vehicle data
    @objc func refreshWithViewModel(model: DriverDetailsViewModel) {
        self.driverDetailsViewModel = model
        self.fillViewWithData()
    }
    
    /// Updates View Components informtation with view model data
    func fillViewWithData() {
        driverStatusMessageLabel.text = driverDetailsViewModel.getDriverMessage()
        driverGenderLabel.text = driverDetailsViewModel.getDriverGenderString()
        driverAgeLabel.text = driverDetailsViewModel.getDriverAgeString()
        driverFullNameLabel.text = driverDetailsViewModel.getDriversFullName()
        numberOfSeats.text = driverDetailsViewModel.getTaxiSeatNumberString()
        taxiTypeLabel.text = driverDetailsViewModel.getFleetTypeString()
        taxiTypeLabel.textColor = driverDetailsViewModel.getFleetTypeTextColor()
        taxiNameLabel.text = driverDetailsViewModel.getTaxiName()
        driverPicView.kf.setImage(with: URL(string: driverDetailsViewModel.getDriverImageString()), placeholder: nil, options: nil, progressBlock: nil) { (result) in
            switch result {
            case .failure(let error):
                debugPrint("Image error: \(error.localizedDescription)")
            case .success(let data):
                debugPrint("Image loaded: \(data.source.cacheKey)")
            }
        }
        taxiImageView.kf.setImage(with: URL(string: driverDetailsViewModel.getTaxiImageLink()), placeholder: nil, options: nil, progressBlock: nil) { (result) in
            switch result {
            case .failure(let error):
                debugPrint("Image error: \(error.localizedDescription)")
            case .success(let data):
                debugPrint("Image loaded: \(data.source.cacheKey)")
            }
        }
        let rating = driverDetailsViewModel.getDriverRating()
        
        for image in ratingImages {
            image.isHidden = !(image.tag <= rating)
        }
    }
    
    /// Adds self to the specified parent view
    ///
    /// - Parameter view: Desired parent view
    @objc func addToView(view: UIView) {
        view.addSubview(self)
        view.sendSubviewToBack(self)
        self.isHidden = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    }
    
    /// Makes the view visible in parent view
    ///
    /// - Parameter view: Parent view to this
    @objc func setVisibleInView(view: UIView) {
        self.frame = view.bounds
        view.bringSubviewToFront(self)
        self.isHidden = false
    }
    
    @objc func closeView() {
        self.isHidden = true
    }
}
