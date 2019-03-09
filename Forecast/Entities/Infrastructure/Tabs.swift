//
//  Tab.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/25/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import UIKit

enum Tabs: CaseIterable {

    case today
    case forecast
}

extension Tabs {
    
    var title: String {
        switch self {
        case .today:
            return "Today"
        case .forecast:
            return "Forecast"
        }
    }

    var image: UIImage {
        switch self {
        case .today:
            return Assets.Images.TabBar.today
        case .forecast:
            return Assets.Images.TabBar.forecast
        }
    }

    var selectedImage: UIImage {
        switch self {
        case .today:
            return Assets.Images.TabBar.todaySelected
        case .forecast:
            return Assets.Images.TabBar.forecastSelected
        }
    }
}
