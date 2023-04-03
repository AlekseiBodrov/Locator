//
//  MainViewController.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {
    // MARK: - constant
    enum Constant {
        static let heightForHeaderInSection: CGFloat = .rowSize
        static let heightForRow: CGFloat = .rowSize
    }

    // MARK: - property
    var mainViewModel: MainViewModelProtocol
    let mainView: MainViewProtocol

    // MARK: - life cycle funcs
    init(mainViewModel: MainViewModelProtocol,
         mainView: MainViewProtocol) {
        self.mainViewModel = mainViewModel
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainViewModel.headerViewFetchData(index: nil)
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        mainViewModel.setSelectedCoordinateWith(indexPath.row)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = mainView.viewForHeaderInSection

        mainViewModel.updateSelectedPersonData = { person, text in
            view.setupWith(person, discription: text)
        }
        return view
    }

    #warning("Это метод делегата")
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.heightForHeaderInSection
    }
    #warning("Это метод делегата")
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.heightForRow
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainViewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.identifier) as? MainTableViewCell else { return UITableViewCell() }

        let person = self.mainViewModel.getPersonFor(indexPath.row)
        #warning("Можно ли эту функцию сразу вызывать внутки вью модели и получать модель Person с заполненным distance?")
        let distance = mainViewModel.getDistancePersonFor(indexPath.row)

        cell.setupWith(person, discription: distance)
        return cell
    }
}

extension MainViewController {
    // MARK: - flow funcs
    private func configureView() {
        view.addSubview(mainView)
        view.backgroundColor = Color.mainColor

        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MainTableViewCell.self,
                                    forCellReuseIdentifier: MainTableViewCell.identifier)

        updateView()
    }

    private func setConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func updateView() {
        mainViewModel.updateViewData = { [unowned self] viewData in
            self.mainView.viewData = viewData
        }
    }
}
