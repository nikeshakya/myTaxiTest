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
    
    var driverDetailsViewModel: DriverDetailsViewModel!
    var topConstraint: NSLayoutConstraint!
    
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
    
    @objc func refreshWithViewModel(model: DriverDetailsViewModel) {
        self.driverDetailsViewModel = model
        self.fillViewWithData()
    }
    
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
    
    @objc func addToView(view: UIView) {
        view.addSubview(self)
        view.sendSubviewToBack(self)
        self.isHidden = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
    }
    
    @objc func setVisibleInView(view: UIView) {
        self.frame = view.bounds
        view.bringSubviewToFront(self)
        self.isHidden = false
    }
    
    @objc func closeView() {
        self.isHidden = true
    }
}
