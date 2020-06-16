//
//  DistanceCounterLongitudeTests.swift
//  DistanceCounterTests
//
//  Created by Yuliia Pavlenko on 14/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import XCTest
@testable import DistanceCounter

class DistanceCounterLongitudeTests: XCTestCase {

    var distanceCalculationViewModel: DistanceCalculationViewModel!
    
    override func setUp() {
        super.setUp()
        
        distanceCalculationViewModel = DistanceCalculationViewModel()
    }
    
    override func tearDown() {
      distanceCalculationViewModel = nil
      super.tearDown()
    }
    
    func testZeroLatitudeShouldBeCorrect() {
        XCTAssertTrue(distanceCalculationViewModel.checkIfLongitudeIsCorrect(with: "0"))
        XCTAssertTrue(distanceCalculationViewModel.checkIfLongitudeIsCorrect(with: "00"))
        XCTAssertTrue(distanceCalculationViewModel.checkIfLongitudeIsCorrect(with: "0.0"))
    }
    
    func testNotZeroPositiveLatitudeShouldBeCorrect() {
        XCTAssertTrue(distanceCalculationViewModel.checkIfLongitudeIsCorrect(with: "180.0"))
    }
    
    func testNotZeroNegativeLatitudeShouldBeCorrect() {
        XCTAssertTrue(distanceCalculationViewModel.checkIfLongitudeIsCorrect(with: "-180"))
    }
    
    func testMaxPositiveLatitudeShouldBeCorrect() {
        XCTAssertFalse(distanceCalculationViewModel.checkIfLongitudeIsCorrect(with: "180.001"))
    }
    
    func testMaxNegativeLatitudeShouldBeCorrect() {
        XCTAssertFalse(distanceCalculationViewModel.checkIfLongitudeIsCorrect(with: "-180.001"))
    }
}
