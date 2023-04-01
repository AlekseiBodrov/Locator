//
//  MainView.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import UIKit
import CoreLocation

protocol MainViewProtocol: UIView {
    var activityIndicator: UIActivityIndicatorView { get set }
    var tableView: UITableView { get }
    var viewForHeaderInSection: InformationView { get }
    var viewData: ViewData { get set }
    var array: [Person]? { get set }
    var selectedPerson: Int? { get set }
}

final class MainView: UIView, MainViewProtocol {
    // MARK: - property
    var viewData: ViewData = .initial {
        didSet {
            setNeedsLayout()
        }
    }

    var selectedPerson: Int? {
        didSet {
            tableView.reloadData()
        }
    }

    let tableView = MainView.makeTable()
    let viewForHeaderInSection = InformationView()
    var activityIndicator: UIActivityIndicatorView = makeActivityIndicatorView()

    var array: [Person]?

    // MARK: - layoutSubviews

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubViews()
        setConstraints()
        configurView()
        viewForHeaderInSection.setConstraints()

        switch viewData {
        case .initial:
            update(viewData: nil, isHidden: true)
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        case .success(let success):
            update(viewData: success, isHidden: false)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        case .failure(let failure):
            update(viewData: failure, isHidden: false)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }

    private func update(viewData: [Person]?, isHidden: Bool) {
        array = viewData
        tableView.isHidden = isHidden
        viewForHeaderInSection.isHidden = isHidden
        tableView.reloadData()
    }
}

extension MainView {
    // MARK: - flow funcs
    private func addSubViews() {
        backgroundColor = Color.mainColor
        addSubview(activityIndicator)
        addSubview(tableView)
        addSubview(viewForHeaderInSection)
    }

    private func configurView() {
        viewForHeaderInSection.backgroundColor = Color.secondaryColor
    }

    private static func makeTable() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }

    private static func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = Color.secondaryColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
