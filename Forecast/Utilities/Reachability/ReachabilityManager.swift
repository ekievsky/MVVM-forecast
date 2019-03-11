//
//  ReachabilityManager.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/26/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import Alamofire

typealias ReachabilityStatus = NetworkReachabilityManager.NetworkReachabilityStatus

protocol ReachabilityManagerDelegate: class {
    func reachabilityManager(_ manager: ReachabilityManager, didReceiveStatus status: ReachabilityStatus)
}

protocol ReachabilityManager {

    var status: ReachabilityStatus { get }
    var isOnline: Bool { get }

    /// Has to be weak
    var delegate: ReachabilityManagerDelegate? { get set }

    func startMonitoring()
    func stopMonitoring()
}
