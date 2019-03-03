//
//  TableViewExtension.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import UIKit

extension UITableView {
    open override func awakeFromNib() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
