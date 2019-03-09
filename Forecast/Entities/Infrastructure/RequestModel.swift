//
//  RequestModel.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/24/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import Foundation
import Alamofire

extension Request {

    struct Model {
        let endpoint: String
        let methodType: HTTPMethod
        let parameters: Parameters?
        let encoding: ParameterEncoding
    }
}

