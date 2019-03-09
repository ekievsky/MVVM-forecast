//
//  ForecastViewController.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 3/5/19.
//  Copyright © 2019 EK. All rights reserved.
//

import RxSwift
import RxCocoa

final class ForecastViewController: BaseViewController {

    override class var nibFile: String? {
        return "ForecastViewController"
    }

    @IBOutlet private var tableView: UITableView!

    private let viewModel: ForecastViewModel
    private let disposeBag = DisposeBag()
    private var data: [(String, [ForecastCellViewModel])] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("ForecastViewController coder init not implemented")
    }

    private func bindViewModel() {
        viewModel.forecast
            .subscribe(onNext: { [weak self] forecast in
                guard let strongSelf = self else { return }
                strongSelf.data = forecast
            }, onError: { [weak self] (error) in
                self?.show(error: error)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension ForecastViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].1.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ForecastTableViewCell.self, selectionStyle: .none)
        let viewModel = data[indexPath.section].1[indexPath.row]
        cell.configure(viewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ForecastViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
}

// MARK: - Entities declaration
private extension ForecastViewController {

    enum Constants {
        static let headerHeight: CGFloat = 32
        static let cellHeight: CGFloat = 80
    }
}
