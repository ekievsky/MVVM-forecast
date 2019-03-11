//
//  ScenesFactory.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/24/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import UIKit

final class SceneFactory {

    static func getTabBar() -> UITabBarController {
        
        let tabs = Tabs.allCases

        let tabBarController = UITabBarController()

        let viewControllers = tabs.enumerated().map { tab -> UINavigationController in
            let viewController = self.getViewController(for: tab.element)
            let navigationController = self.getNavigationController(rootViewController: viewController)
            navigationController.tabBarItem = self.getTabBarItem(tab: tab.element, index: tab.offset)
            return navigationController
        }

        tabBarController.setViewControllers(viewControllers, animated: true)

        return tabBarController
    }

    static func getForecastScene() -> ForecastViewController {

        let apiService = ApiServiceImpl()

        let viewModel = ForecastViewModel(apiService: apiService)
        let view = ForecastViewController(viewModel: viewModel)

        return view
    }

    static func getTodayWeatherScene() -> TodayWeatherViewController {

        let apiService = ApiServiceImpl()

        let viewModel = TodayWeatherViewModel(apiService: apiService)
        let view = TodayWeatherViewController(viewModel: viewModel)

        return view
    }
}

extension SceneFactory {

    static func getViewController(for type: Tabs) -> UIViewController {
        switch type {
        case .forecast:
            return getForecastScene()
        case .today:
            return getTodayWeatherScene()
        }
    }

    static func getTabBarItem(tab: Tabs, index: Int) -> UITabBarItem {

        let item = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)

        item.tag = index

        return item
    }

    static func getNavigationController(rootViewController: UIViewController) -> UINavigationController {

        return UINavigationController(rootViewController: rootViewController)
    }
}
