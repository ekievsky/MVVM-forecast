//
//  TodayWeatherViewController.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 3/5/19.
//  Copyright © 2019 EK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TodayWeatherViewController: BaseViewController {

    override class var nibFile: String? {
        return "TodayWeatherViewController"
    }

    // MARK: Outlets
    @IBOutlet private weak var weatherConditionImageView: UIImageView!
    @IBOutlet private weak var placeTitle: UILabel!
    @IBOutlet private weak var weatherTitle: UILabel!

    @IBOutlet private weak var humidityTitle: UILabel!
    @IBOutlet private weak var rainVolumeTitle: UILabel!
    @IBOutlet private weak var pressureTitle: UILabel!
    @IBOutlet private weak var windSpeedTitle: UILabel!
    @IBOutlet private weak var windDirectionTitle: UILabel!

    private let viewModel: TodayWeatherViewModel
    private let disposeBag = DisposeBag()

    // MARK: Variables
    private var shownViewModel: TodayWeatherShownViewModel?
    private var cityName: String?

    // MARK: Lifecycle
    init(viewModel: TodayWeatherViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("ForecastViewController coder init not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        bindViewModel()
    }

    private func bindViewModel() {
        rx.viewWillAppear
            .bind(to: viewModel.viewWillAppearSubject)
            .disposed(by: disposeBag)

        viewModel.weather
            .asDriver(onErrorJustReturn: .empty)
            .drive(onNext: { [weak self] shownViewModel in
                self?.shownViewModel = shownViewModel

                if let url = URL(string: shownViewModel.image) {
                    self?.weatherConditionImageView.sd_setImage(with: url, completed: nil)
                }
                LocationManager.shared.getCity { (placemarks, _) in
                    self?.cityName = placemarks?.first?.locality
                    self?.placeTitle.text = "\(self?.cityName ?? "") \(shownViewModel.locationDescription)"
                }

                self?.weatherTitle.text = "\(shownViewModel.degrees) | \(shownViewModel.weatherType)"
                self?.humidityTitle.text = shownViewModel.humidity
                self?.rainVolumeTitle.text = shownViewModel.rainVolume
                self?.pressureTitle.text = shownViewModel.pressure
                self?.windSpeedTitle.text = shownViewModel.windSpeed
                self?.windDirectionTitle.text = shownViewModel.windDirection
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - Private configure
private extension TodayWeatherViewController {

    func configureTitle() {
        title = "Today"
    }

    func showActivityController() {
        guard
            let viewModel = self.shownViewModel,
            let cityName = self.cityName
            else { return }

        let content = ["Look at the weather in \(viewModel.locationDescription) – \(cityName).",
            "It is \(viewModel.degrees) and \(viewModel.weatherType) here!"]
        let activityController = UIActivityViewController(activityItems: content, applicationActivities: nil)
        present(activityController, animated: true)
    }
}

// MARK: - Actions
extension TodayWeatherViewController {
    @IBAction
    private func shareButtonAction(_ sender: UIButton) {
        showActivityController()
    }
}
