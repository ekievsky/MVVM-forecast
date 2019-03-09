//
//  Assets.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/26/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import UIKit

enum Assets {

    enum Images { }
}

extension Assets.Images {

    enum Common {
        static let refresh = UIImage(named: "icRefresh")
    }

    enum TabBar {
        static let today = UIImage(named: "icToday")!
        static let todaySelected = UIImage(named: "icTodaySelected")!
        static let forecast = UIImage(named: "icForecast")!
        static let forecastSelected = UIImage(named: "icForecastSelected")!
    }
}
