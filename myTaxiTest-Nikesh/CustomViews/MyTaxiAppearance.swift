//
//  MyTaxiAppearance.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//
import UIKit

class MyTaxiAppearance {
    
    static func apply() {
        customizeNavigationBar()
    }
    
    fileprivate static func customizeNavigationBar() {
        let appearance = UINavigationBar.appearance()
        appearance.isTranslucent = true
        appearance.setBackgroundImage(UIImage(), for: .default)
        appearance.shadowImage = UIImage()
        appearance.tintColor = UIColor(red: 0.34, green: 0.39, blue: 0.48, alpha: 1)
        var fontSize = CGFloat(17).relativeToIphone8Width()
        let maxNavBarSize: CGFloat = 30
        if fontSize > maxNavBarSize {
            fontSize = maxNavBarSize
        }
        let font = UIFont.systemFont(ofSize: fontSize)
        appearance.titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let barButtonAppearance = UIBarButtonItem.appearance()
        barButtonAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        barButtonAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
    }
    
}
