//
//  TableView+Dequeue.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/25/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import UIKit

extension UITableView {

    func dequeueCell<T: UITableViewCell & ReuseProtocol>(_ cellClass: T.Type, selectionStyle: UITableViewCell.SelectionStyle) -> T {

        let cell = self.dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as! T

        cell.selectionStyle = selectionStyle

        return cell
    }
}

