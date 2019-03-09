//
//  Date+StringConverting.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/25/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import Foundation

extension Date {
    
    var fulldayString: String {
        return DateFormatter.fullday.string(from: self)
    }

    var fullDateString: String {
        return DateFormatter.fullDateTime.string(from: self)
    }

    var time: String {
        return DateFormatter.time.string(from: self)
    }
}
