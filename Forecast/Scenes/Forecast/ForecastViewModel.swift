//
//  ForecastViewModel.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 3/5/19.
//  Copyright © 2019 EK. All rights reserved.
//

import RxSwift

final class ForecastViewModel {

    private let apiService: ApiService
    private let locationManager: LocationManager

    private let disposeBag = DisposeBag()

    init(apiService: ApiService, locationManager: LocationManager) {
        self.apiService = apiService
        self.locationManager = locationManager
    }

    lazy var forecast: Observable<[(String, [ForecastCellViewModel])]> = {
        return locationManager.location.asObservable()
            .flatMap { [weak self] location -> Observable<[Forecast]> in
                guard let strongSelf = self, let location = location else {
                    return Observable.just([])
                }
                return strongSelf.apiService
                    .getForecast(latitude: location.latitude, longitude: location.longitude)
                    .asObservable()
            }
            .map { [weak self] array in
                return self?.groupData(array) ?? []
            }
    }()
}

private extension ForecastViewModel {

    func groupData(_ data: [Forecast]) -> [(String, [ForecastCellViewModel])] {

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
