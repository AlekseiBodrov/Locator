//
//  MainView.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import UIKit

protocol MainViewProtocol: UIView {
    var tableView: UITableView { get }
}

final class MainView: UIView, MainViewProtocol {
    // MARK: - property
    let tableView = MainView.makeTable()

    // MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(tableView)
        layout()
    }

    // MARK: - flow funcs
    private static func makeTable() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .yellow

        return tableView
    }

    private func layout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

