//
//  LocationStatisticsViewModel.swift
//  myTaxiTest-NikeshTests
//
//  Created by Nikesh Shakya on 3/3/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import XCTest
@testable import myTaxiTest_Nikesh

class LocationStatisticsViewModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEquality(model: LocationStatisticModel, viewModel: LocationStatisticsViewModel) {
        XCTAssertEqual(model, viewModel.model)
    }
    
    func testMapViewModelEqualsMarkerModel() {
        let locationStatModel = TestService.getTestLocationStatisticObject()
        let locationStatisticsViewModel = LocationStatisticsViewModel(model: locationStatModel, city: "Banepa", country: "Nepal")
        testEquality(model: locationStatModel, viewModel: locationStatisticsViewModel)
    }
    

}
