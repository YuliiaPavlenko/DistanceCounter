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
}
