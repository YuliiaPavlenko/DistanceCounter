//
//  ApiError.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 06/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

enum ApiError: String, Error {
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your Internet connection."
}

