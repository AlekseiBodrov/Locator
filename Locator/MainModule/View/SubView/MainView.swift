//
//  MainView.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import UIKit

protocol MainViewProtocol: UIView {
    var tableView: UITableView { get }
    var viewForHeaderInSection: UIView { get }
}

final class MainView: UIView, MainViewProtocol {
    // MARK: - property
    let tableView = MainView.makeTable()
    var viewForHeaderInSection: UIView = InformationView().instanceFromNib()

    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubViews()
        setConstraints()
    }

    // MARK: - flow funcs
    private static func makeTable() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }

    private func addSubViews() {
        addSubview(tableView)
        addSubview(viewForHeaderInSection)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

