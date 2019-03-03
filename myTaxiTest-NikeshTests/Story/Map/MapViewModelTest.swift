//
//  MapViewModelTest.swift
//  myTaxiTest-NikeshTests
//
//  Created by Nikesh Shakya on 3/3/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import XCTest
@testable import myTaxiTest_Nikesh

class MapViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEquality(marker: Marker, model: MapViewViewModel) {
        XCTAssertEqual(marker, model.markers[0])
    }
    
    func testMapViewModelEqualsMarkerModel() {
        let vehicle = TestService.getTestVehicleObject()
        let marker = TestService.getTestMarkerObject(withVehicle: vehicle)
        let mapViewViewModel = MapViewViewModel(markers: [marker])
        testEquality(marker: marker, model: mapViewViewModel)
    }
    
}
