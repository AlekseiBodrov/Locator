//
//  MainViewController.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: - constant
    enum Constant {
        static let heightForHeaderInSection: CGFloat = 200
        static let heightForRow: CGFloat = 100
    }

    // MARK: - property
    var viewModel: MainViewModelProtocol?
    var mainView: MainViewProtocol?

    // MARK: - life cycle funcs
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - flow funcs
    private func configureView() {
        mainView?.tableView.delegate = self
        mainView?.tableView.dataSource = self
        mainView?.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        viewModel?.updateData {}
    }

}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as? MainTableViewCell else {
            return UITableViewCell()
        }
        guard let person = viewModel?.personArray[indexPath.row] else { return UITableViewCell() }
        cell.setupWith(person)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return mainView?.viewForHeaderInSection
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.heightForHeaderInSection
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.heightForRow
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows() ?? 0
    }
}
