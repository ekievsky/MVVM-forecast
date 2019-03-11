//
//  WindDirectionUtility.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/26/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import Foundation

protocol WindDirectionUtility {

    /// Method provide string with the direction of the wind
    ///
    /// - Parameter degrees: degrees in Double
    /// - Returns: string wind direction
    func getWindDirection(from degrees : Double) -> String
}
