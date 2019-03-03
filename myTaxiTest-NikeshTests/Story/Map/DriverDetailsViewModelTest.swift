//
//  DriverDetailsViewModelTest.swift
//  myTaxiTest-NikeshTests
//
//  Created by Nikesh Shakya on 3/3/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import XCTest
@testable import myTaxiTest_Nikesh

class DriverDetailsViewModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEquality(driverModel: Driver, vehicleModel: Vehicle, viewModel: DriverDetailsViewModel) {
        XCTAssertEqual(driverModel, viewModel.driverModel)
        XCTAssertEqual(vehicleModel, viewModel.taxiModel)
    }
    
    func testDriverDetailsViewModelEqualityToAllChildModels() {
        let driver = TestService.getTestDriverObject()
        let taxi = TestService.getTestVehicleObject()
        let viewModel = DriverDetailsViewModel(taxiModel: taxi, driverModel: driver)
        testEquality(driverModel: driver, vehicleModel: taxi, viewModel: viewModel)
    }
    
    func testDriverStatusMessage() {
        let driver = TestService.getTestDriverObject()
        let taxi = TestService.getTestVehicleObject()
        let viewModel = DriverDetailsViewModel(taxiModel: taxi, driverModel: driver)
        XCTAssertEqual(driver.statusMessage.rawValue, viewModel.getDriverMessage())
    }

}
