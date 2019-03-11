//
//  TodayWeatherShownViewModel.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 3/11/19.
//  Copyright © 2019 EK. All rights reserved.
//

import Foundation

struct TodayWeatherShownViewModel {

    let image: String
    let locationDescription: String
    let degrees: String
    let weatherType: String
    let humidity: String
    let rainVolume: String
    let pressure: String
    let windSpeed: String
    let windDirection: String
}

extension TodayWeatherShownViewModel {
    static var empty: TodayWeatherShownViewModel {
        return TodayWeatherShownViewModel(
            image: "-", locationDescription: "-", degrees: "-",
            weatherType: "-", humidity: "-",
            rainVolume: "-", pressure: "-",
            windSpeed: "-", windDirection: "-"
        )
    }
}
