//
//  ForecastViewModel.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 3/5/19.
//  Copyright © 2019 EK. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreLocation

final class ForecastViewModel {

    typealias GroupedForecastViewModel = [(String, [ForecastCellViewModel])]

    private let apiService: ApiService
    private let locationManager: LocationManager

    private let disposeBag = DisposeBag()

    // Input
    let viewWillAppearSubject = PublishSubject<Bool>()

    // Output
    var forecast: Observable<GroupedForecastViewModel> = .empty()

    init(apiService: ApiService, locationManager: LocationManager = .shared) {
        self.apiService = apiService
        self.locationManager = locationManager

        self.forecast = viewWillAppearSubject
            .flatMap { _ in
                return locationManager.location.asObservable()
            }
            .flatMap { location -> Observable<[Forecast]> in
                guard let location = location else { return .empty() }

                return apiService.getForecast(latitude: location.latitude, longitude: location.longitude)
                    .asObservable()
            }
            .map { [weak self] forecast in
                return self?.groupData(forecast) ?? []
            }
            .asObservable()
    }
}

private extension ForecastViewModel {

    func groupData(_ data: [Forecast]) -> GroupedForecastViewModel {

        var models: [(String, [ForecastCellViewModel])] = []
        let dates = Set(data.map { $0.fullDayString } )

        dates.forEach { date in
            let oneDayModels = data
                .filter { $0.fullDayString == date }
                .map { model -> ForecastCellViewModel in
                    let temperature = Int(model.temperature) - 273
                    return ForecastCellViewModel(image: model.weather.icon,
                                             time: model.time,
                                             weatherType: model.weather.main,
                                             weatherDescription: model.weather.description,
                                             degree: String(temperature))
                }
            models.append((date, oneDayModels))
        }

        return models.sorted(by: { (lhs, rhs) -> Bool in
            return lhs.0 < rhs.0
        })
    }
}
