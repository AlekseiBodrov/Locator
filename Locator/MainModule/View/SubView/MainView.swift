//
//  MainView.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import UIKit
import CoreLocation

protocol MainViewProtocol: CommonInitView {
    var activityIndicator: UIActivityIndicatorView { get }
    var tableView: UITableView { get }
    var viewForHeaderInSection: ViewForHeaderInSection { get set }
    var viewData: ViewData { get set }
}

final class MainView: CommonInitView, MainViewProtocol {

    // MARK: - property
    var viewData: ViewData = .initial {
        didSet {
            setNeedsLayout()
        }
    }

    var tableView = UITableView()
    var viewForHeaderInSection = ViewForHeaderInSection()
    var activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - commonInit
    override func commonInit() {
        addSubViews()
        configurView()
        setConstraints()
    }

    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()

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

        tableView.reloadData()
    }
}

extension MainView {
    // MARK: - flow funcs
    private func addSubViews() {
        addSubview(viewForHeaderInSection)
        addSubview(activityIndicator)
        addSubview(tableView)
    }

    private func configurView() {
        backgroundColor = Color.mainColor
        viewForHeaderInSection.backgroundColor = Color.secondaryColor

        activityIndicator.color = Color.secondaryColor
        activityIndicator.hidesWhenStopped = true
    }

    private func update(viewData: [Person]?, isHidden: Bool) {
        tableView.isHidden = isHidden
        viewForHeaderInSection.isHidden = isHidden
        tableView.reloadData()
    }

    private func setConstraints() {
        tableView.viewAnchors(self)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
