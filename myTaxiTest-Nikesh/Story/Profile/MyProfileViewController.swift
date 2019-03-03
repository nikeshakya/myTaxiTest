//
//  MyProfileViewController.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/3/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import UIKit
import WebKit

class MyProfileViewController: UIViewController {
    // MARK:- Outlet Properties and Action Methods
    @IBOutlet weak var myPortfolioWebView: WKWebView!
    @IBAction func backDitTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URLRequest(url: URL(string: "http://nikeshakya.com.np")!)
        myPortfolioWebView.load(url)
    }

}
