//
//  BaseViewController.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/25/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    class var nibFile: String? {
        return nil
    }

    // MARK: Init
    init() {
        super.init(nibName: type(of: self).nibFile, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Base View Input
    func show(error: Error) {
        show(message: error.localizedDescription, title: "Error")
    }

    func showLoader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }

    func hideLoader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}


