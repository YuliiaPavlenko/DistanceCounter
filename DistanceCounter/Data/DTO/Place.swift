//
//  Place.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 06/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct Place: Codable {
    var placeID: Int?
    var licence, osmType: String?
    var osmID: Int?
    var lat, lon: String?
    var placeRank: Int?
    var category, type: String?
    var importance: Double?
    var addresstype, name, displayName: String?
    var address: Address?
    var boundingbox: [String]?

    enum CodingKeys: String, CodingKey {
        case placeID
        case licence
        case osmType
        case osmID
        case lat, lon
        case placeRank
        case category, type, importance, addresstype, name
        case displayName
        case address, boundingbox
    }
}
