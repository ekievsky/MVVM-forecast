//
//  Day.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/24/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import SwiftyJSON

struct Forecast {

    let id: Int
    let temperature: Float
    let temperatureMin: Float
    let temperatureMax: Float
    let pressure: Float
    let humidity: Int
    let windSpeed: Int
    let windDegree: Double
    let clouds: Int
    let countryCode: String
    let date: Date
    let weather: Weather

    var fullDayString: String {
        return date.fulldayString
    }

    var fullDateString: String {
        return date.fullDateString
    }

    var time: String {
        return date.time
    }


    /// Create Forecast model from JSON
    ///
    /// - Parameter json: data received from API
    /// - Important: model will not be created if there is no 'id' or 'weather'
    init?(json: JSON) {
        guard
            let id = json["dt"].int,
            let weather = Weather(json: json["weather"]) else { return nil }

        let mainJSON = json["main"]
        self.temperature = mainJSON["temp"].floatValue
        self.temperatureMin = mainJSON["temp_min"].floatValue
        self.temperatureMax = mainJSON["temp_max"].floatValue
        self.pressure = mainJSON["pressure"].floatValue
        self.humidity = mainJSON["humidity"].intValue
        self.id = id

        let cloudsJSON = json["clouds"]
        self.clouds = cloudsJSON["all"].intValue

        let windJSON = json["wind"]
        self.windSpeed = windJSON["speed"].intValue
        self.windDegree = windJSON["deg"].doubleValue

        let stringDate = json["dt_txt"].stringValue
        let date = DateFormatter.fullDateTime.date(from: stringDate) ?? Date()
        self.date = date

        let sys = json["sys"]
        self.countryCode = sys["country"].stringValue

        self.weather = weather
    }
}
