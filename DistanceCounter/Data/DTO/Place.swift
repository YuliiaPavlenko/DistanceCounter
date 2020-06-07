//
//  Place.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 06/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

// MARK: - Place
struct Place: Codable {
    var type: String?
    var features: [Feature]?
}

// MARK: - Feature
struct Feature: Codable {
    var type: String?
    var properties: Properties?
}

// MARK: - Properties
struct Properties: Codable {
    var geocoding: PropertiesGeocoding?
}

// MARK: - PropertiesGeocoding
struct PropertiesGeocoding: Codable {
    var placeID: Int?
    var osmType: String?
    var osmID: Int?
    var type: String?
    var accuracy: Int?
    var label, name, country: String?
}
