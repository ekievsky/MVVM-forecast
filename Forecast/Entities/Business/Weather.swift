//
//  Weather.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/25/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import SwiftyJSON

final class Weather {
    
    let id: Int
    let main: String
    let description: String
    let icon: String

    init?(json: JSON) {
        guard let jsonValue = json.arrayValue.first,
            let id = jsonValue["id"].int else { return nil }
        self.main = jsonValue["main"].stringValue
        self.description = jsonValue["description"].stringValue
        self.id = id

        let icon = jsonValue["icon"].stringValue
        self.icon = "http://openweathermap.org/img/w/\(icon).png"
    }
}
