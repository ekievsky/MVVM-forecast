//
//  AppDelegate.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 3/5/19.
//  Copyright © 2019 EK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var reachability: ReachabilityManager = {
        let manager = ReachabilityManagerImpl()
        manager.delegate = self
        return manager
    }()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        showMainUI()

        reachability.startMonitoring()

        return true
    }

    private func showMainUI() {

        let viewController = SceneFactory.getTabBar()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
}

extension AppDelegate: ReachabilityManagerDelegate {
    func reachabilityManager(_ manager: ReachabilityManager, didReceiveStatus status: ReachabilityStatus) {
        switch status {
        case .notReachable:
            window?.rootViewController?.show(message: "You are currently offline", title: "Oops")
        case .unknown :
            print("It is unknown whether the network is reachable")
        case .reachable:
            NotificationCenter.default.post(name: .internetRestored, object: nil)
        }
    }
}
