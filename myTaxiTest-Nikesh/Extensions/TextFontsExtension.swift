//
//  TextFontsExtension.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import UIKit

extension UILabel {
    open override func awakeFromNib() {
        self.font = self.font.withSize(self.font.pointSize.relativeToIphone8Width())
    }
}

extension UITextView {
    open override func awakeFromNib() {
        self.font = self.font?.withSize((self.font?.pointSize.relativeToIphone8Width())!)
    }
}

extension UITextField {
    open override func awakeFromNib() {
        self.font = self.font?.withSize((self.font?.pointSize.relativeToIphone8Width())!)
    }
}

extension UIButton {
    open override func awakeFromNib() {
        self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize.relativeToIphone8Width())!)
    }
    
    /// Sets background color of the button with respect to button state
    ///
    /// - Parameters:
    ///   - color: UIColor value to be set for specified button state
    ///   - forState: State of the button
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
        self.clipsToBounds = true
    }
    
}
