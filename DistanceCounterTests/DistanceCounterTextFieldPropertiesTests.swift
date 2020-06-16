//
//  DistanceCounterTextFieldPropertiesTests.swift
//  DistanceCounterTests
//
//  Created by Yuliia Pavlenko on 14/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import XCTest
@testable import DistanceCounter

class DistanceCounterTextFieldPropertiesTests: XCTestCase {
    
    var sut: DistanceCalculationViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: "DistanceCalculationViewController") as? DistanceCalculationViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testDistanceCounterForm_WhenLoaded_TextFieldAreConnected() throws {
     _ = try XCTUnwrap(sut.startPointLatitudeTextField, "Start Point Latitude UITextField is not connected")
     _ = try XCTUnwrap(sut.startPointLongitudeTextField, "Start Point Longitude UITextField is not connected")
     _ = try XCTUnwrap(sut.finishPointLatitudeTextField, "Finish Point Latitude UITextField is not connected")
     _ = try XCTUnwrap(sut.finishPointLongitudeTextField, "Finish Point Longitude UITextField is not connected")
    }
    
    func testStartPointLatitudeTextField_WhenCreated_HasNumbersKeyboardTypeSet() throws {
      
         let startPointLatitudeTextField = try XCTUnwrap(sut.startPointLatitudeTextField, "Start Point Latitude UITextField is not connected")
        XCTAssertEqual(startPointLatitudeTextField.keyboardType, UIKeyboardType.numbersAndPunctuation, "Start Point Latitude UITextField does not have numbers and punctuations Keyboard type set")
    }
    
    func testStartPointLongitudeTextField_WhenCreated_HasNumbersKeyboardTypeSet() throws {
      
         let startPointLongitudeTextField = try XCTUnwrap(sut.startPointLongitudeTextField, "Start Point Longitude UITextField is not connected")
        XCTAssertEqual(startPointLongitudeTextField.keyboardType, UIKeyboardType.numbersAndPunctuation, "Start Point Longitude UITextField does not have numbers and punctuations Keyboard type set")
    }

    func testFinishPointLatitudeTextField_WhenCreated_HasNumbersKeyboardTypeSet() throws {
      
         let finishPointLatitudeTextField = try XCTUnwrap(sut.finishPointLatitudeTextField, "Finish Point Latitude UITextField is not connected")
        XCTAssertEqual(finishPointLatitudeTextField.keyboardType, UIKeyboardType.numbersAndPunctuation, "Finish Point Latitude UITextField does not have Email Keyboard type set")
    }
    
    func testFinishPointLongitudeTextField_WhenCreated_HasNumbersKeyboardTypeSet() throws {
      
         let finishPointLongitudeTextField = try XCTUnwrap(sut.finishPointLongitudeTextField, "Finish Point Longitude UITextField is not connected")
        XCTAssertEqual(finishPointLongitudeTextField.keyboardType, UIKeyboardType.numbersAndPunctuation, "Finish Point Longitude UITextField does not have Email Keyboard type set")
    }
    
    func testCalculateDistanceButton_WhenCreated_HasActionAssigned() {
        
        //Check if Controller has UIButton property
        let calculateDistanceButton: CustomButton = sut.calculateDistanceButton
        XCTAssertNotNil(calculateDistanceButton, "Distance Calculation View Controller does not have UIButton property")
        
        // Attempt Access UIButton Actions
        guard let calculateDistanceButtonActions = calculateDistanceButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
            return
        }
     
        // Assert UIButton has action with a method name
        XCTAssertTrue(calculateDistanceButtonActions.contains("calculateDistanceButtonClicked:"))
    }

}
