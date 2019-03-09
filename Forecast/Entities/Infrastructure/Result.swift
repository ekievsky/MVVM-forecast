//
//  Result.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/25/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import Foundation

enum Result<T> {
    
    case success(T)
    case failure(Error)
}
