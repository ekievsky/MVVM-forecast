//
//  ReuseProtocol.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/25/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import UIKit

public protocol ReuseProtocol {

    static var className: String {get}
}

public extension ReuseProtocol {

    static var reuseIdentifier: String {
        return className
    }

    static func nib() -> UINib {
        return UINib(nibName: className, bundle: nil)
    }
}

public extension ReuseProtocol {

    static var className: String {
        return String(describing: self)
    }
}

public extension UITableView {

    func registerCell(_ cell: ReuseProtocol.Type) {
        register(cell.nib(), forCellReuseIdentifier: cell.reuseIdentifier)
    }

    func registerSupplimentaryView(_ cell: ReuseProtocol.Type) {
        register(cell.nib(), forHeaderFooterViewReuseIdentifier: cell.reuseIdentifier)
    }
}
