//
//  Locale+CountryName.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/26/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import Foundation

extension Locale {

    func countryName(from countryCode: String) -> String? {
        return Locale.current.localizedString(forRegionCode: countryCode)
    }
}
