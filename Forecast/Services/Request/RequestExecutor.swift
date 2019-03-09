//
//  NetworkManager.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/24/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import Alamofire
import SwiftyJSON
import RxSwift

extension Request {

    class Executor {
        static let shared = Executor()

        private let manager : SessionManager
        private let configuration: URLSessionConfiguration = {
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            return config
        }()

        private init() {
            self.manager = SessionManager(configuration: configuration)
        }

        func request(model: Model) -> Single<JSON> {
            return Single.create(subscribe: { observer in
                self.manager.request(model.endpoint,
                                method: model.methodType,
                                parameters: model.parameters,
                                encoding: model.encoding,
                                headers: nil)
                    .responseJSON { response in
                        let result = response.result
                        switch result {
                        case .success(let value):
                            guard let json = JSON(arrayLiteral: value).arrayValue.first else {
                                observer(.error(ForecastError.executorParserError))
                                return
                            }
                            observer(.success(json))
                        case .failure(let error):
                            observer(.error(error))
                        }
                }
                return Disposables.create()
            })
        }
    }
}
