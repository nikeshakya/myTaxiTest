//
//  CGFloatExtension.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import UIKit

let minScalableValue: CGFloat = 8.0 // Min value that should undergo upper scaling for bigger iphones and iPads
extension CGFloat {
    
    /// Converts the stored value into relative value with respect to iphone 8 device screen width
    ///
    /// - Parameter shouldUseLimit: Boolean representing whether the calculation should consider the minimum scalable value
    /// - Returns: Relatively converted value after the calculation
    func relativeToIphone8Width(shouldUseLimit: Bool = true) -> CGFloat {
        let upperScaleLimit: CGFloat = 1.8
        let toUpdateValue = floor(self * (UIScreen.main.bounds.width / 375))
        guard self > minScalableValue else {return toUpdateValue}
        guard shouldUseLimit else {return toUpdateValue}
        let limitedValue = self * upperScaleLimit
        return toUpdateValue > limitedValue ? limitedValue : toUpdateValue
    }
    
    /// Converts the stored value into relative value with respect to iphone 8 device screen height
    ///
    /// - Parameter shouldUseLimit: Boolean representing whether the calculation should consider the minimum scalable value
    /// - Returns: Relatively converted value after the calculation
    func relativeToIphone8Height(shouldUseLimit: Bool = true) -> CGFloat {
        var extraHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            extraHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            extraHeight = extraHeight + (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 20) - 20
        }
        let upperScaleLimit: CGFloat = 1.8
        let toUpdateValue = floor(self * ((UIScreen.main.bounds.height - extraHeight) / 667))
        guard self > minScalableValue else {return toUpdateValue}
        guard shouldUseLimit else {return toUpdateValue}
        let limitedValue = self * upperScaleLimit
        return toUpdateValue > limitedValue ? limitedValue : toUpdateValue
    }
}
