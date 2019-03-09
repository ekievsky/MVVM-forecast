//
//  ForecastError.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/25/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import Foundation

enum ForecastError {
    
    case executorParserError
    case failedToFetchLocation
    case couldNotGetTodayWeather
    case couldNotGetCurrentLocation
}

extension ForecastError: Error {

    var localizedDescription: String {
        switch self {
        case .executorParserError:
            return "Error parsing Request.Executor"
        case .failedToFetchLocation:
            return "Location fetching failed"
        case .couldNotGetTodayWeather:
            return "Could not get today weather. \n Please, try again"
        case .couldNotGetCurrentLocation:
            return "Could not get current location"
        }
    }
}
