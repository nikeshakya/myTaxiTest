//
//  Driver.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation

enum Gender: String {
    case male
    case female
}

enum Rating: Int {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    
    /// Generates and returns random rating value
    ///
    /// - Returns: rating value in range 3 - 5
    static func random() -> Rating {
        let ratingsList: [Rating] = [.three, .four, .five]
        return ratingsList.randomElement()!
    }
}

enum DriverStatusMessage: String {
    case available = "Hey!, I will be at your location in 2 minutes.\nDo you want me to pick you up?"
    case delayedAvailable = "Hello there!,\nI just completed my last ride.\nWhoaa, it was a long route. Are you looking for me to give you a ride?\nWill be available in 5 minutes."
    case busy = "Hey Hey Hey !!!,\nThank you for visiting my profile.\nUnfortunately I am busy right now.\nWe shall meet in future. Good Day!!"
    case unavailable = "Sorry! I am not available at the moment.\nI hope you understand. Take care and have a safe ride."
    
    /// Generates and returns random status message from list of stored messages
    ///
    /// - Returns: Driver's current status message
    static func random() -> DriverStatusMessage {
        let allData: [DriverStatusMessage] = [.available, .delayedAvailable, .busy, .unavailable]
        return allData.randomElement()!
    }
}

class Driver: NSObject{
    var id: Int?
    var taxiId: Int?
    var profilePicture: String?
    var fullName: String?
    var age: Int?
    var statusMessage: DriverStatusMessage!
    var gender: Gender?
    var rating: Rating?
}

extension Driver {
    public static func == (lhs: Driver, rhs: Driver) -> Bool {
        return lhs.id == rhs.id && lhs.taxiId == rhs.taxiId && lhs.fullName == rhs.fullName && lhs.age == rhs.age && lhs.gender == rhs.gender && lhs.rating == rhs.rating
    }
}
