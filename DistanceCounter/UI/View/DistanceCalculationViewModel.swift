//
//  DistanceCalculationViewModel.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 06/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation
import CoreLocation

class DistanceCalculationViewModel {
    
    weak var view: DistanceCalculationViewProtocol?
        
    let latitudeRange = -90.0...90.0
    let longitudeRange = -180.0...180.0
    
    var isStartLatitudeFilledCorrect = false
    var isStartLongituteFilledCorrect = false
    var isFinishLatitudeFilledCorrect = false
    var isFinishLongituteFilledCorrect = false
    
    private func checkIfUserInputIsValid(correctRange: ClosedRange<Double>, userInput: String) -> Bool {
        let convertedUserInput = Double(userInput) ?? .nan
        return correctRange.contains(convertedUserInput)
    }
    
    func checkIfLatitudeIsCorrect(with userInput: String) -> Bool {
        
        let isCorrect = checkIfUserInputIsValid(correctRange: latitudeRange, userInput: userInput)
        if !isCorrect {
            view?.showIncorrectUserInput(with: "invalid_format".localized(), message: "invalid_latitude".localized())
        }
        return isCorrect
    }
    
    func checkIfLongitudeIsCorrect(with userInput: String) -> Bool {
       
        let isCorrect = checkIfUserInputIsValid(correctRange: longitudeRange, userInput: userInput)
        if !isCorrect {
            view?.showIncorrectUserInput(with: "invalid_format".localized(), message: "invalid_longitude".localized())
        }
        return isCorrect
    }

    func validateStartLatitudeField(with userInput: String) {
        isStartLatitudeFilledCorrect = checkIfLatitudeIsCorrect(with: userInput)
    }
    
    func validateStartLongituteField(with userInput: String) {
        isStartLongituteFilledCorrect = checkIfLongitudeIsCorrect(with: userInput)
    }
    
    func validateFinishLatitudeField(with userInput: String) {
        isFinishLatitudeFilledCorrect = checkIfLatitudeIsCorrect(with: userInput)
    }
    
    func validateFinishLongituteField(with userInput: String) {
        isFinishLongituteFilledCorrect = checkIfLongitudeIsCorrect(with: userInput)
    }
    
    func calculateDistanceButtonClicked(startLatitude: String, startLongitude: String,
                                        finishLatitude: String, finishLongitude: String) {
        
        getStartPoint(with: startLatitude, and: startLongitude)
        
        getFinishPoint(with: finishLatitude, and: finishLongitude)
        
        calculateDistanceBetween(startLatitude: startLatitude, startLongitude: startLongitude,
                                 finishLatitude: finishLatitude, finishLongitude: finishLongitude)
        
    }
    
    private func getStartPoint(with latitude: String, and longitute: String) {
        
        getPointsData(with: latitude, and: longitute) { [weak self] place in
        guard let self = self else { return }
            if let _ = place {
                self.view?.showStartPointInfo(for: "Start point is in: \n\(place!)")
            } else {
                self.view?.presentAlertOnMainThread(title: "error".localized(), message: "unable_geocode_start_place".localized(), buttonTitle: "ok".localized())
                self.view?.showStartPointInfo(for: "unknown_location".localized())
            }
        }
    }
    
    private func getFinishPoint(with latitude: String, and longitute: String) {
        
        getPointsData(with: latitude, and: longitute) { [weak self] place in
        guard let self = self else { return }
            if let _ = place {
                self.view?.showFinishPointInfo(for: "Finish point is in: \n\(place!)")
            } else {
                self.view?.presentAlertOnMainThread(title: "error".localized(), message: "unable_geocode_finish_place".localized(), buttonTitle: "ok".localized())
                self.view?.showFinishPointInfo(for: "unknown_location".localized())
            }
        }
    }
    
    private func getPointsData(with latitude: String, and longitute: String, completion: @escaping (String?)-> ()) {
        
        view?.showLoadingView()
        
        let latitude = Double(latitude) ?? .nan
        let longitute = Double(longitute) ?? .nan
        
        NetworkManager.shared.getPointWith(latitude: latitude, longitute: longitute) { [weak self] result in
            guard let self = self else { return }
             self.view?.dismissLoadingView()
            
            switch result {
            case .success(let place):
                completion(place.features?[0].properties?.geocoding?.label)
            case .failure(let error):
                self.view?.presentAlertOnMainThread(title: "error".localized(), message: error.rawValue, buttonTitle: "ok".localized())
            }
        }
    }
    
    private func calculateDistanceBetween(startLatitude: String, startLongitude: String, finishLatitude: String, finishLongitude: String) {
        
        let startLatitude = Double(startLatitude) ?? .nan
        let startLongitude = Double(startLongitude) ?? .nan
        let finishLatitude = Double(finishLatitude) ?? .nan
        let finishLongitude = Double(finishLongitude) ?? .nan
            
        let startPoint = Point(latitude: startLatitude, longitude: startLongitude)
        let finishPoint = Point(latitude: finishLatitude, longitude: finishLongitude)
            
        calculateDistanceBetween(startPoint, and: finishPoint)
    }

    private func calculateDistanceBetween(_ startPoint: Point, and finishPoint: Point) {
        
        let startPoint = CLLocation(latitude: startPoint.latitude, longitude: startPoint.longitude)
        let finishPoint = CLLocation(latitude: finishPoint.latitude, longitude: finishPoint.longitude)
        let distance = startPoint.distance(from: finishPoint)
        
        let distanceInMeters = String(format: "%.2f", distance)
        let distanceInKilometers = String(format: "%.2f", distance / 1000)
        
        view?.setDistanceInKilometers("Distance in kilometers = \(distanceInKilometers)")
        view?.setDistanceInMeters("Distance in meters = \(distanceInMeters)")
    }
}

struct Point {
    let latitude: Double
    let longitude: Double
}
