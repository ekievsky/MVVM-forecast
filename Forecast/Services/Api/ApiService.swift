//
//  ApiService.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/24/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import RxSwift

protocol ApiService {

    func getForecast(latitude: Double, longitude: Double) -> Single<[Forecast]>
    func getTodayWeather(latitude: Double, longitude: Double) -> Single<Forecast?>
}
