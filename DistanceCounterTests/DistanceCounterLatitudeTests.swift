//
//  DistanceCounterLatitudeTests.swift
//  DistanceCounterTests
//
//  Created by Yuliia Pavlenko on 14/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import XCTest
@testable import DistanceCounter

class DistanceCounterLatitudeTests: XCTestCase {
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
        XCTAssertTrue(distanceCalculationViewModel.checkIfLatitudeIsCorrect(with: "0"))
        XCTAssertTrue(distanceCalculationViewModel.checkIfLatitudeIsCorrect(with: "00"))
        XCTAssertTrue(distanceCalculationViewModel.checkIfLatitudeIsCorrect(with: "0.0"))
    }
    
    func testNotZeroPositiveLatitudeShouldBeCorrect() {
        XCTAssertTrue(distanceCalculationViewModel.checkIfLatitudeIsCorrect(with: "90.0"))
    }
    
    func testNotZeroNegativeLatitudeShouldBeCorrect() {
        XCTAssertTrue(distanceCalculationViewModel.checkIfLatitudeIsCorrect(with: "-90"))
    }
    
    func testMaxPositiveLatitudeShouldBeCorrect() {
        XCTAssertFalse(distanceCalculationViewModel.checkIfLatitudeIsCorrect(with: "90.001"))
    }
    
    func testMaxNegativeLatitudeShouldBeCorrect() {
        XCTAssertFalse(distanceCalculationViewModel.checkIfLatitudeIsCorrect(with: "-90.001"))
    }
}
