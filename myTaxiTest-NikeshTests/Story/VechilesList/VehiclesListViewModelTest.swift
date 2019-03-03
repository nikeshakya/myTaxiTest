//
//  VehicleViewModelTest.swift
//  myTaxiTest-NikeshTests
//
//  Created by Nikesh Shakya on 3/3/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import XCTest
@testable import myTaxiTest_Nikesh

class VehiclesListViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEquality(vehicle: Vehicle, model: VehiclesListViewModel) {
        XCTAssertEqual(vehicle, model.vehicles[0])
    }
    
    func testVehicleViewModelEqualsVehicleModel() {
        let vehicle = TestService.getTestVehicleObject()
        let vehiclesListViewModel = VehiclesListViewModel(with: [vehicle])
        testEquality(vehicle: vehicle, model: vehiclesListViewModel)
    }
    
    
    func testVehicleCoordinateAddress() {
        let vehicle = TestService.getTestVehicleObject()
        let vehiclesListViewModel = VehiclesListViewModel(with: [vehicle])
        let expectation = XCTestExpectation()
        testEquality(vehicle: vehicle, model: vehiclesListViewModel)
        vehiclesListViewModel.fetchAddressFromCoordinate(forModel: vehicle, completion: {
            (data, error) in
            XCTAssert(data != nil)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
    }
    
    
}
