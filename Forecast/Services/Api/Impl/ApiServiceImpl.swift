//
//  ApiService.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/24/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import RxSwift

final class ApiServiceImpl: ApiService {

    private let executor = Request.Executor.shared
    private let requestModelsFactory = RequestModelFactory()

    func getForecast(latitude: Double, longitude: Double) -> Single<[Forecast]> {
        let model = requestModelsFactory.getForecast(latitude: latitude, longitude: longitude)

        return executor.request(model: model)
            .map { json in
                let models = json["list"].arrayValue.compactMap { Forecast(json: $0) }
                return models
            }
    }

    func getTodayWeather(latitude: Double, longitude: Double) -> Single<Forecast?> {

        let model = requestModelsFactory.getTodayWeather(latitude: latitude, longitude: longitude)

        return executor.request(model: model)
            .map { Forecast(json: $0) }
    }
}
