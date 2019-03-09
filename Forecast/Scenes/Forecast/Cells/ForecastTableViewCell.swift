//
//  ForecastTableViewCell.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/25/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import UIKit
import SDWebImage

final class ForecastTableViewCell: UITableViewCell, ReuseProtocol {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var degreeLabel: UILabel!

    func configure(_ viewModel: ForecastCellViewModel) {
        iconImageView.sd_setImage(with: URL(string: viewModel.image)!, completed: nil)
        timeLabel.text = viewModel.time
        weatherLabel.text = "\(viewModel.weatherType) / \(viewModel.weatherDescription)"
        degreeLabel.text = "\(viewModel.degree)°"
    }
}
