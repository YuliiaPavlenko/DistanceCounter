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
    var geocoding: WelcomeGeocoding?
    var features: [Feature]?
}

// MARK: - Feature
struct Feature: Codable {
    var type: String?
    var properties: Properties?
    var geometry: Geometry?
}

// MARK: - Geometry
struct Geometry: Codable {
    var type: String?
    var coordinates: [Double]?
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

    enum CodingKeys: String, CodingKey {
        case placeID
        case osmType
        case osmID
        case type, accuracy, label, name, country
    }
}

// MARK: - WelcomeGeocoding
struct WelcomeGeocoding: Codable {
    var version, attribution, licence, query: String?
}
