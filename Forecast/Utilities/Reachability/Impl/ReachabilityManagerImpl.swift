//
//  ReachabilityManagerImpl.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/26/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import Alamofire

final class ReachabilityManagerImpl: ReachabilityManager {

    private let reachabilityManager = NetworkReachabilityManager(host: Constants.host)

    weak var delegate: ReachabilityManagerDelegate?

    var isOnline: Bool {
        return status != .notReachable && status != .unknown
    }

    var status: ReachabilityStatus = .unknown

    func startMonitoring()  {
        reachabilityManager?.listener = { [weak self] status in
            guard let strongSelf = self else { return }
            strongSelf.status = status
            strongSelf.delegate?.reachabilityManager(strongSelf, didReceiveStatus: status)
        }
        reachabilityManager?.startListening()
    }

    func stopMonitoring() {
        reachabilityManager?.stopListening()
    }
}

private extension ReachabilityManagerImpl {
    enum Constants {
        static let host = "www.google.com"
    }
}

