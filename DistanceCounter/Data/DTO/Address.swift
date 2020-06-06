//
//  Address.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 06/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

struct Address: Codable {
    var road, village, stateDistrict, state: String?
    var postcode, country, countryCode: String?

    enum CodingKeys: String, CodingKey {
        case road, village
        case stateDistrict
        case state, postcode, country
        case countryCode
    }
}
