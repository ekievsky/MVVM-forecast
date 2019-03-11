//
//  TodayWeatherViewModel.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 3/11/19.
//  Copyright © 2019 EK. All rights reserved.
//

import RxSwift
import RxCocoa

final class TodayWeatherViewModel {

    private let apiService: ApiService
    private let locationManager: LocationManager
    private let windUtility: WindDirectionUtility

    // Input
    let viewWillAppearSubject = PublishSubject<Bool>()

    // Output
    var weather: Observable<TodayWeatherShownViewModel> = .empty()

    init(apiService: ApiService, locationManager: LocationManager = .shared, windUtility: WindDirectionUtility = WindDirectionUtilityImpl.shared) {
        self.apiService = apiService
        self.locationManager = locationManager
        self.windUtility = windUtility

        self.weather = self.viewWillAppearSubject
            .asObservable()
            .flatMap { _ in
                return locationManager.location.asObservable()
            }
            .flatMap { location -> Observable<TodayWeatherShownViewModel> in
                guard let location = location else { return .empty() }
                return apiService.getTodayWeather(latitude: location.latitude, longitude: location.longitude)
                    .asObservable()
                    .map { [weak self] weather -> TodayWeatherShownViewModel in
                        return self?.getViewModel(weather: weather) ?? .empty
                    }
            }
    }
}

// MARK: - Private methods
private extension TodayWeatherViewModel {

    func getViewModel(weather: Forecast?) -> TodayWeatherShownViewModel {
        guard let weather = weather else { return .empty }

        let temperature = "\(Int(weather.temperature) - 273)°C"
        let pressure = "\(Int(weather.pressure)) hPa"
        let humidity = "\(weather.humidity)%"
        let windSpeed = "\(weather.windSpeed) km/h"
        let windDirection = windUtility.getWindDirection(from: weather.windDegree)
        return TodayWeatherShownViewModel(
            image: weather.weather.icon,
            locationDescription: weather.countryCode, degrees: temperature,
            weatherType: weather.weather.main, humidity: humidity,
            rainVolume: "N/A", pressure: pressure,
            windSpeed: windSpeed, windDirection: windDirection
        )
    }
}
