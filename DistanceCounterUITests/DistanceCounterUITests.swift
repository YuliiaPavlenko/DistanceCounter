//
//  DistanceCounterUITests.swift
//  DistanceCounterUITests
//
//  Created by Yuliia Pavlenko on 13/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import XCTest

class DistanceCounterUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }

    func testIfTextFieldsNotEmpty() {
        
        let latitudeOfStartPointTextField = app.textFields["Latitude of start point"]
        latitudeOfStartPointTextField.tap()
        
        let longitudeOfStartPointTextField = app.textFields["Longitude of start point"]
        longitudeOfStartPointTextField.tap()
        
        let latitudeOfFinishPointTextField = app.textFields["Latitude of finish point"]
        latitudeOfFinishPointTextField.tap()
        
        let longitudeOfFinishPointTextField = app.textFields["Longitude of finish point"]
        longitudeOfFinishPointTextField.tap()
        
        let calculateDistanceButton = app.buttons["Calculate Distance"]
        
        app.staticTexts["Calculate Distance"].tap()
        
        
        if !latitudeOfStartPointTextField.title.isEmpty && !longitudeOfStartPointTextField.title.isEmpty && !latitudeOfFinishPointTextField.title.isEmpty && !longitudeOfFinishPointTextField.title.isEmpty {
            XCTAssertTrue(calculateDistanceButton.isEnabled)
        } else {
            XCTAssertFalse(calculateDistanceButton.isEnabled)
        }
        
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
