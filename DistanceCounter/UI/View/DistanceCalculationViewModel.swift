//
//  DistanceCalculationViewModel.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 06/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

class DistanceCalculationViewModel {
    
    weak var view: DistanceCalculationViewProtocol?
    
    let latitudeRange = -90.0...90.0
    let longitudeRange = -180.0...180.0
    
    private func checkIfUserInputIsValid(correctRange: ClosedRange<Double>, userInput: String) -> Bool {
        let convertedUserInput = Double(userInput) ?? .nan
        return correctRange.contains(convertedUserInput)
    }
    
    func checkIfLatitudeIsCorrect(userInput: String) {
        if !checkIfUserInputIsValid(correctRange: latitudeRange, userInput: userInput) {
            view?.showIncorrectUserInput(with: "Aaa", message: "Bbb")
        }
    }
    
    func checkIfLongitudeIsCorrect(userInput: String) {
        if !checkIfUserInputIsValid(correctRange: longitudeRange, userInput: userInput) {
            view?.showIncorrectUserInput(with: "Aaa", message: "Bbb")
        }
    }
}
