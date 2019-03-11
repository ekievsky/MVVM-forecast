//
//  WindDirectionUtility.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/26/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import Foundation

class WindDirectionUtilityImpl: WindDirectionUtility {

    static let shared = WindDirectionUtilityImpl()

    /// Hidden init to make sure that there is only one instance of Singleton
    private init() {}

    func getWindDirection(from degrees : Double) -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let i = Int((degrees + 11.25) / 22.5)
        return directions[i % 8]
    }
}
