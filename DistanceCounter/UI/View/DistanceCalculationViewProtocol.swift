//
//  DistanceCalculationViewProtocol.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 06/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

protocol DistanceCalculationViewProtocol: class {
    func showIncorrectUserInput(with title: String, message: String)
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String)
    func showLoadingView()
    func dismissLoadingView()
    func showStartPointInfo(for place: String)
    func showFinishPointInfo(for place: String)
    func setDistanceInKilometers(_ distance: String)
    func setDistanceInMeters(_ distance: String)
}
