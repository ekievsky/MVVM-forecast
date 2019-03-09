//
//  DateFormatter.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/24/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let fullDateTime: DateFormatter = {
        return DateFormatter.dateFormatter(withFormat: "yyyy-MM-dd HH:mm:ss")
    }()

    static let fullday: DateFormatter = {
        return DateFormatter.dateFormatter(withFormat: "yyyy-MM-dd")
    }()

    static let time: DateFormatter = {
        return DateFormatter.dateFormatter(withFormat: "HH:mm")
    }()

    static func dateFormatter(withFormat format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
