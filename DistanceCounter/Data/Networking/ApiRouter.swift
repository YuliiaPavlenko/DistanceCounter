//
//  ApiRouter.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 06/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

class ApiRouter {
    private static let format = Config.baseURL + "/reverse?format=geocodejson"
    
    static func pointFor(latitude: Double, longitute: Double) -> String {
        return format + "&lat=\(latitude)&lon=\(longitute)"
    }
}
